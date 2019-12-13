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

            if (IsPostBack)
            {
                 + "\\" + newName;
                ImageLoader.SaveImage(FileUpload1, Server.MapPath("images"))
            }
        }



        public void GetSubcategoriesByCategoryId(int category_id)
        {
            string queryString = "SELECT subcategories.id as subcategory_id, subcategories.name as subcategory_name FROM subcategories " +
                "WHERE subcategories.category_id = @subcategory_id";

            SqlCommand select = new SqlCommand(queryString, connection);
            select.CommandType = CommandType.Text;
            select.Parameters.Add("@subcategory_id", SqlDbType.Int).Value = category_id;
            using (SqlDataAdapter adapter = new SqlDataAdapter(select))
            {
                adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;
                DataSet subcategories = new DataSet();
                adapter.Fill(subcategories);

                DropDownList2.DataSource = subcategories;
                DropDownList2.DataBind();
            }
        }

        public void GetCitiesByRegionId(int region_id)
        {
            string queryString = "SELECT cities.id as city_id, cities.name as city_name FROM cities WHERE cities.region_id = @region_id";

            SqlCommand select = new SqlCommand(queryString, connection);
            select.CommandType = CommandType.Text;
            select.Parameters.Add("@region_id", SqlDbType.Int).Value = region_id;
            using (SqlDataAdapter adapter = new SqlDataAdapter(select))
            {
                adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;
                DataSet cities = new DataSet();
                adapter.Fill(cities);

                DropDownList4.DataSource = cities;
                DropDownList4.DataBind();
            }
        }

        protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList list = (DropDownList)sender;
            int regionId = int.Parse(list.SelectedValue);
           // GetCitiesByRegionId(regionId);
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList list = (DropDownList)sender;
            int categoryId = int.Parse(list.SelectedValue);
           // GetSubcategoriesByCategoryId(categoryId);
        }
    }
}