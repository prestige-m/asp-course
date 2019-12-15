using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Callboard
{
    public partial class LoginForm : System.Web.UI.Page
    {
        public SqlConnection connection = null;

        public static string GetHash(MD5 md5, string input)
        {
            byte[] data = md5.ComputeHash(Encoding.UTF8.GetBytes(input));
            StringBuilder stringBuilder = new StringBuilder();
            for (int i = 0; i < data.Length; i++)
                stringBuilder.Append(data[i].ToString("x2"));
            return stringBuilder.ToString();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition
            {
                Path = "~/js/jquery-3.2.1.min.js",
            });

            string connectionString = WebConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            connection = new SqlConnection(connectionString);
        }

        protected void Login(object sender, EventArgs e)
        {
            try
            {
                connection.Open();
                SqlCommand select = new SqlCommand("SELECT * FROM users WHERE email = @email and password = @password", connection);
                select.CommandType = CommandType.Text;
                select.Parameters.AddWithValue("@email", email.Text);
                select.Parameters.AddWithValue("@password", GetHash(MD5.Create(), password.Text));
                SqlDataReader reader = select.ExecuteReader();
                while (reader.Read())
                {
                    Session.RemoveAll();
                    Session.Add("id", reader["id"].ToString());
                    Session.Add("email", reader["email"].ToString());
                    Session.Add("first_name", reader["first_name"].ToString());
                    Session.Add("last_name", reader["last_name"].ToString());
                    Session.Add("patronymic", reader["patronymic"].ToString());
                    Session.Add("phone", reader["phone"].ToString());
                    Session.Add("role_id", reader["role_id"].ToString());
                    Session.Add("city_id", reader["city_id"].ToString());
                    Response.Redirect("index.aspx");
                }
                errors.Text = "Користувача не знайдено!";
            }
            catch
            {
                errors.Text = "Виникла помилка на стороні сервера.";
                password.Text = "";
            }
            finally
            {
                connection.Close();
            }
        }
    }
}