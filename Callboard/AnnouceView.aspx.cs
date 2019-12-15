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
    public partial class AnnouceView : System.Web.UI.Page
    {
        public SqlConnection connection = null;
        public string referer = "~/index.aspx";
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            connection = new SqlConnection(connectionString);

            referer = $"~/{Request.UrlReferrer.ToString().Split('/')[3]}";
            if (Request.QueryString["announce_id"] != null && Request.QueryString["announce_id"] != "")
            {
                int announceId = int.Parse(Request.QueryString["announce_id"]);
                GetAnounceById(announceId);
                HyperLink2.NavigateUrl = referer;
            }
            else { 
                Response.Redirect("~/AnnouceView.aspx?announce_id=2");
                HyperLink2.NavigateUrl = referer;
            }
        }

        public void GetAnounceById(int id)
        {
            string queryString = "SELECT announcements.id as id, title, user_id, users.first_name as user_name,  announcements.subcategory_id as subcategory_id, " +
               "subcategories.name as subcategory_name, categories.name as category_name, categories.id as category_id,city_id, announcements.image_name, " +
               "cities.name as city_name, regions.name as region_name, announcements.creation_date, message_text, price FROM announcements " +
               "INNER JOIN subcategories ON subcategories.id = announcements.subcategory_id " +
               "INNER JOIN categories ON subcategories.category_id = categories.id " +
               "INNER JOIN cities ON cities.id = announcements.city_id " +
               "INNER JOIN regions ON regions.id = cities.region_id " +
               "INNER JOIN users ON users.id = announcements.user_id " +
               "WHERE announcements.id=@announce_id";

            connection.Open();
            SqlCommand select = new SqlCommand(queryString, connection);
            select.CommandType = CommandType.Text;
            select.Parameters.Add("@announce_id", SqlDbType.Int).Value = id;

            SqlDataReader reader = select.ExecuteReader();
            reader.Read();

            Image1.ImageUrl = $"~/images/{reader["image_name"].ToString()}";
            Label1.Text = reader["title"].ToString();
            Label2.Text = $"{reader["category_name"].ToString()} / {reader["subcategory_name"].ToString()} / м. {reader["city_name"].ToString()}";
            Label3.Text = reader["user_name"].ToString();
            Label4.Text = reader["message_text"].ToString();
            Label5.Text = $"Оголошення № {reader["id"].ToString()}, розміщено {reader["creation_date"].ToString()}";
            connection.Close();
        }
    }
}