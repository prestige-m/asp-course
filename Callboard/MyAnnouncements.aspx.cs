using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Callboard
{
    public partial class MyAnnouncements : System.Web.UI.Page
    {
        public SqlConnection connection = null;
        public DataSet announcements = new DataSet();
        public const string announceQuery = "SELECT announcements.id as id, title, user_id, announcements.subcategory_id as subcategory_id, " +
               "subcategories.name as subcategory_name, categories.name as category_name, categories.id as category_id,city_id, image_name, " +
               "cities.name as city_name, regions.name as region_name, creation_date, message_text, price FROM announcements " +
               "INNER JOIN subcategories ON subcategories.id = announcements.subcategory_id " +
               "INNER JOIN categories ON subcategories.category_id = categories.id " +
               "INNER JOIN cities ON cities.id = announcements.city_id " +
               "INNER JOIN regions ON regions.id = cities.region_id " +
               "WHERE user_id=@user_id"; 

        protected void Page_Load(object sender, EventArgs e)
        {
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition
            {
                Path = "~/js/jquery-3.2.1.min.js",
            });

            string connectionString = WebConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            connection = new SqlConnection(connectionString);

            if (Request.QueryString["delete_id"] != null && Request.QueryString["delete_id"] != "")
            {
                int announceId = int.Parse(Request.QueryString["delete_id"]);
                Alert alert = new Alert();
                DeleteAnnounceById(announceId);
                alert.AddMessageAlert("Оголошення видалено.");
                msg.InnerHtml = alert.GetAlerts();
            }
            SearchAnnounce();
        }

        public void SearchAnnounce()
        {
            string queryString = announceQuery;
            int userId = 0;
            if(Session["id"] != null)
            {
               userId = int.Parse(Session["id"].ToString());
            }
            else
            {
                return;
            }
            

            SqlCommand select = new SqlCommand(queryString, connection);
            select.CommandType = CommandType.Text;
            select.Parameters.Add("@user_id", SqlDbType.Int).Value = userId;

            using (SqlDataAdapter adapter = new SqlDataAdapter(select))
            {
                adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;
                announcements = new DataSet();
                adapter.Fill(announcements);

                RepeaterItems.DataSource = announcements;
                RepeaterItems.DataBind();
            }
        }

        public void DeleteAnnounceById(int id)
        {
            string queryString = "DELETE FROM announcements WHERE id=@id";

            connection.Open();
            SqlCommand select = new SqlCommand(queryString, connection);
            select.CommandType = CommandType.Text;
            select.Parameters.Add("@id", SqlDbType.Int).Value = id;
            try
            {
                select.ExecuteNonQuery();
            }
            catch { }
            finally
            {
                connection.Close();
            }
        }
    }
}
