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
    public partial class index : System.Web.UI.Page
    {
        public SqlConnection connection = null;
        public DataSet announcements = new DataSet();
        public const string announceQuery = "SELECT announcements.id as id, title, user_id, announcements.subcategory_id as subcategory_id, " +
               "subcategories.name as subcategory_name, categories.name as category_name, categories.id as category_id,city_id, image_name, " +
               "cities.name as city_name, regions.name as region_name, creation_date, message_text, price FROM announcements " +
               "INNER JOIN subcategories ON subcategories.id = announcements.subcategory_id " +
               "INNER JOIN categories ON subcategories.category_id = categories.id " +
               "INNER JOIN cities ON cities.id = announcements.city_id " +
               "INNER JOIN regions ON regions.id = cities.region_id ";

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
                
            }

            if (Request.QueryString["search_by_category_id"] != null && Request.QueryString["search_by_category_id"]!="")
            {
                int categoryId = int.Parse(Request.QueryString["search_by_category_id"]);
                SearchAnnounceByCategoryId(categoryId);
            }
            else
            {
                SearchAnnounce();
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            SearchAnnounce();
        }

        public void SearchAnnounce()
        {
            string queryString = announceQuery +
               "WHERE categories.name LIKE @search_value OR cities.name LIKE @search_value OR message_text LIKE @search_value OR " +
               "title LIKE @search_value OR subcategories.name LIKE @search_value OR regions.name LIKE @search_value";

            string searchValue = Search.Text.Trim().ToLowerInvariant();
            SqlCommand select = new SqlCommand(queryString, connection);
            select.CommandType = CommandType.Text;
            select.Parameters.Add("@search_value", SqlDbType.VarChar, 150).Value = $"%{searchValue}%";

            using (SqlDataAdapter adapter = new SqlDataAdapter(select))
            {
                adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;
                announcements = new DataSet();
                adapter.Fill(announcements);

                RepeaterItems.DataSource = announcements;
                RepeaterItems.DataBind();
            }
        }

        public void SearchAnnounceByCategoryId(int categoryId)
        {
            string queryString = announceQuery + "WHERE categories.id = @category_id";

            SqlCommand select = new SqlCommand(queryString, connection);
            select.CommandType = CommandType.Text;
            select.Parameters.Add("@category_id", SqlDbType.Int).Value = categoryId;

            using (SqlDataAdapter adapter = new SqlDataAdapter(select))
            {
                adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;
                announcements = new DataSet();
                adapter.Fill(announcements);

                RepeaterItems.DataSource = announcements;
                RepeaterItems.DataBind();
            }
        }
    }
}