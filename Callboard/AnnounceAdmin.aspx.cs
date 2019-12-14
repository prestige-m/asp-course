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
    public partial class AnnounceAdmin : System.Web.UI.Page
    {
        SqlConnection connection = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition
            {
                Path = "~/js/jquery-3.2.1.min.js",
            });

            string connectionString = WebConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            connection = new SqlConnection(connectionString);
            if (!Page.IsPostBack)
            {
                refreshdata();
            }
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            refreshdata();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt16(GridView1.DataKeys[e.RowIndex].Values["id"].ToString());
            SqlCommand cmd = new SqlCommand("delete from announcements where id = @id", connection);
            cmd.Parameters.AddWithValue("@id", id);
            connection.Open();
            cmd.ExecuteNonQuery();
            connection.Close();
            refreshdata();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            refreshdata();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["id"].ToString());

            TextBox txtTitle = GridView1.Rows[e.RowIndex].FindControl("TextBox2") as TextBox;
            DropDownList userId = GridView1.Rows[e.RowIndex].FindControl("DropDownList1") as DropDownList;
            DropDownList subcategoryId = GridView1.Rows[e.RowIndex].FindControl("DropDownList2") as DropDownList;
            DropDownList cityId = GridView1.Rows[e.RowIndex].FindControl("DropDownList3") as DropDownList;
            TextBox txtImage = GridView1.Rows[e.RowIndex].FindControl("TextBox3") as TextBox;
            TextBox txtDate = GridView1.Rows[e.RowIndex].FindControl("TextBox4") as TextBox;
            TextBox txtMessage = GridView1.Rows[e.RowIndex].FindControl("TextBox5") as TextBox;
            TextBox txtPrice = GridView1.Rows[e.RowIndex].FindControl("TextBox6") as TextBox;

            SqlCommand cmd = new SqlCommand("Update announcements SET title=@title, user_id=@user_id, subcategory_id=@subcategory_id, city_id=@city_id,"
                                 +"image_name = @image_name, creation_date = @creation_date, message_text = @message_text, price = @price WHERE id = @id", connection);
            cmd.Parameters.AddWithValue("@title", txtTitle.Text);
            cmd.Parameters.AddWithValue("@user_id", userId.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@subcategory_id", subcategoryId.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@city_id", cityId.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@image_name", txtImage.Text);
            cmd.Parameters.AddWithValue("@creation_date", txtDate.Text);
            cmd.Parameters.AddWithValue("@message_text", txtMessage.Text);
            cmd.Parameters.AddWithValue("@price", txtPrice.Text);
            cmd.Parameters.AddWithValue("@id", id);
            connection.Open();
            cmd.ExecuteNonQuery();
            connection.Close();
            refreshdata();
        }

        public void refreshdata()
        {
            SqlCommand cmd = new SqlCommand("SELECT * FROM announcements", connection);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
}