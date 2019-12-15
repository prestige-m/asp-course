using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Callboard
{
    public partial class CreateAnnouncement : System.Web.UI.Page
    {
        public SqlConnection connection = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition
            {
                Path = "~/js/jquery-3.2.1.min.js",
            });
            string connectionString = WebConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            connection = new SqlConnection(connectionString);

        }

        [WebMethod()]
        [System.Web.Script.Services.ScriptMethod]
        public static List<City> GetCitiesInRegion(int regionID)
        {
            CityService service = new CityService();
            return service.GetCitiesInRegion(regionID);
        }

        public int ChangeImage(int id, string imageName)
        {
            string queryStr = "UPDATE announcements SET image_name=@image_name WHERE id=@id";

            int result = 0;
            connection.Open();
            SqlCommand command = new SqlCommand(queryStr, connection);
            command.CommandType = CommandType.Text;
            command.Parameters.Add("@image_name", SqlDbType.VarChar, 100).Value = imageName;
            command.Parameters.Add("@id", SqlDbType.Int).Value = id;

            try
            {
                result = command.ExecuteNonQuery();
            }
            catch {}
            finally
            {
                connection.Close();
            }
            return result;
        }

        public int InsertAnnounce(string title, int user_id, int subcategory_id, string message, decimal? price)
        {
            string queryStr = "INSERT INTO announcements (title, user_id, subcategory_id, message_text, price) " +
                         "VALUES (@title, @user_id, @subcategory_id, @message, @price)";
            if (price == null)
            {
                queryStr = "INSERT INTO announcements (title, user_id, subcategory_id, message_text) " +
                        "VALUES (@title, @user_id, @subcategory_id, @message)";
            }

            int lastID= 0;
            connection.Open();
            SqlCommand command = new SqlCommand(queryStr, connection);
            command.CommandType = CommandType.Text;
            command.Parameters.Add("@title", SqlDbType.VarChar, 150).Value = title;
            command.Parameters.Add("@user_id", SqlDbType.Int).Value = user_id;
            command.Parameters.Add("@subcategory_id", SqlDbType.Int).Value = subcategory_id;
            command.Parameters.Add("@message", SqlDbType.Text).Value = message;
            if (price != null)
                command.Parameters.Add("@price", SqlDbType.Decimal).Value = price;

            try
            {
                command.ExecuteNonQuery();
                string sql = "SELECT MAX(id) AS LastID FROM announcements";
                SqlCommand select = new SqlCommand(sql, connection);
                select.CommandType = CommandType.Text;
                SqlDataReader reader = select.ExecuteReader();
                reader.Read();
                lastID = int.Parse(reader["LastID"].ToString());
            }
            catch { }
            finally
            {
                connection.Close();
            }
            return lastID;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string title = TextBox1.Text;
            int subcategory_id = int.Parse(DropDownList1.SelectedValue);
            string message = TextBox2.Text;
            decimal? price = null;
            int userId = int.Parse(Session["id"].ToString());
            try
            {
                price = decimal.Parse(TextBox3.Text);
            }
            catch
            {
                price = null;
            }

            Alert alerts = new Alert();
            int annouce_id = InsertAnnounce(title, userId, subcategory_id, message, price);
            if (annouce_id > 0)
            {
                alerts.AddMessageAlert("Оголошення успішно додано.");
                string pattern = "item";
                string imageName = ImageLoader.SaveImage(ref alerts, FileUpload1, Server.MapPath("images"), pattern, annouce_id);
                ChangeImage(annouce_id, imageName);
            }
            else
            {
                alerts.AddErrorAlert("Помилка при завантаженні даних у базу!");
            }
            msg.InnerHtml = alerts.GetAlerts();
        }
    }
}