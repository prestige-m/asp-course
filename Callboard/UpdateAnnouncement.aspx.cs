using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.Services;

namespace Callboard
{
    public partial class UpdateAnnouncement : System.Web.UI.Page
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

            if(!IsPostBack)
            {
                if (Request.QueryString["id"] != null && Request.QueryString["id"] != "")
                {
                    int announceId = int.Parse(Request.QueryString["id"]);
                    GetAnnounceById(announceId);
                }
                else
                {
                    Response.Redirect("~/index.aspx");  
                }
            }   
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
            catch { }
            finally
            {
                connection.Close();
            }
            return result;
        }


        public void GetAnnounceById(int id)
        {
            string queryStr = "SELECT announcements.id as id, title, user_id, announcements.subcategory_id as subcategory_id, subcategories.name as subcategory_name," +
                        "categories.name as category_name, categories.id as category_id, " +
                        "city_id, image_name, cities.name as city_name, regions.name as region_name, creation_date, message_text, price FROM announcements " +
                        "INNER JOIN subcategories ON subcategories.id = announcements.subcategory_id " +
                        "INNER JOIN categories ON subcategories.category_id = categories.id " +
                        "INNER JOIN cities ON cities.id = announcements.city_id " +
                        "INNER JOIN regions ON regions.id = cities.region_id " +
                        "WHERE announcements.id = @id";

            connection.Open();
            SqlCommand command = new SqlCommand(queryStr, connection);
            command.CommandType = CommandType.Text;
            command.Parameters.Add("@id", SqlDbType.Int).Value = id;
            SqlDataReader reader = command.ExecuteReader();
            reader.Read();
                  
            try
            {
                TextBox1.Text = reader["title"].ToString();
                DropDownList1.SelectedIndex = DropDownList1.Items.IndexOf(DropDownList1.Items.FindByValue(reader["category_name"].ToString()));
                DropDownList2.SelectedIndex = DropDownList2.Items.IndexOf(DropDownList2.Items.FindByValue(reader["subcategory_name"].ToString()));
                DropDownList3.SelectedIndex = DropDownList3.Items.IndexOf(DropDownList3.Items.FindByValue(reader["region_name"].ToString()));
                DropDownList4.SelectedIndex = DropDownList4.Items.IndexOf(DropDownList4.Items.FindByValue(reader["city_name"].ToString()));
                TextBox2.Text = reader["message_text"].ToString();
                TextBox3.Text = reader["price"].ToString();
            }
            catch {
            
            }
            finally
            {
                connection.Close();
            }
        }

        public int UpdateAnnounce(int id, string title, int user_id, int subcategory_id, int city_id, string message, decimal? price)
        {
            string queryStr = "UPDATE announcements SET title=@title, user_id=@user_id, subcategory_id=@subcategory_id," +
                " city_id=@city_id, message_text=@message_text, price=@price WHERE id=@id";

            if (price == null)
            {
                queryStr = "UPDATE announcements SET title=@title, user_id=@user_id, subcategory_id=@subcategory_id," +
                " city_id=@city_id, message_text=@message_text WHERE id=@id";
            }

            int result = 0;
            connection.Open();
            SqlCommand command = new SqlCommand(queryStr, connection);
            command.CommandType = CommandType.Text;
            command.Parameters.Add("@id", SqlDbType.Int).Value = id;
            command.Parameters.Add("@title", SqlDbType.VarChar, 150).Value = title;
            command.Parameters.Add("@user_id", SqlDbType.Int).Value = user_id;
            command.Parameters.Add("@subcategory_id", SqlDbType.Int).Value = subcategory_id;
            command.Parameters.Add("@city_id", SqlDbType.Int).Value = city_id;
            command.Parameters.Add("@message_text", SqlDbType.Text).Value = message;
            if (price != null)
                command.Parameters.Add("@price", SqlDbType.Decimal).Value = price;

            try
            {
                result = command.ExecuteNonQuery();
            }
            catch {
            }
            finally
            {
                connection.Close();
            }
            return result;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string title = TextBox1.Text;
            int city_id = int.Parse(DropDownList1.SelectedValue);
            int subcategory_id = int.Parse(DropDownList3.SelectedValue);
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
            int announceId = 0;
            if (Request.QueryString["id"] != null && Request.QueryString["id"] != "")
            {
                announceId = int.Parse(Request.QueryString["id"]);
            }
            int result = UpdateAnnounce(announceId, title, userId, subcategory_id, city_id, message, price);
            if (result != 0)
            {
                alerts.AddMessageAlert("Оголошення успішно змінено.");
                string pattern = "item";
                string imageName = ImageLoader.SaveImage(ref alerts, FileUpload1, Server.MapPath("images"), pattern, announceId);
                ChangeImage(announceId, imageName);
            }
            else
            {
                alerts.AddErrorAlert("Помилка при завантаженні даних у базу!");
            }

            //Response.Write(alerts.GetAlerts());
            msg.InnerHtml = alerts.GetAlerts();
        }
    }
}
