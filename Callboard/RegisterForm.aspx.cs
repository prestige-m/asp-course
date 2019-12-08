using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Callboard
{
    public partial class RegisterForm : System.Web.UI.Page
    {
        public SqlConnection connection = null;
        private const int DEFAULT_ROLE_ID = 2;

        protected void Page_Load(object sender, EventArgs e)
        {
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition
            {
                Path = "~/js/jquery-3.2.1.min.js",
            });

            string connectionString = WebConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            connection = new SqlConnection(connectionString);
        }

        public static string GetHash(MD5 md5, string input)
        {
            byte[] data = md5.ComputeHash(Encoding.UTF8.GetBytes(input));
            StringBuilder stringBuilder = new StringBuilder();
            for (int i = 0; i < data.Length; i++)
                stringBuilder.Append(data[i].ToString("x2"));
            return stringBuilder.ToString();
        }

        protected void Registration(object sender, EventArgs e)
        {
            if (password.Text == password_repeat.Text)
            {
                try
                {
                    bool error = false;
                    connection.Open();
                    string sql = "SELECT email FROM users";
                    SqlCommand select = new SqlCommand(sql, connection);
                    select.CommandType = CommandType.Text;
                    SqlDataReader reader = select.ExecuteReader();
                    while (reader.Read())
                    {
                        if (email.Text == reader["email"].ToString())
                        {
                            errors.Text = "Користувач з таким e-mail вже існує!";
                            password.Text = password_repeat.Text = "";
                            error = true;
                            break;
                        }
                    }
                    if (!error)
                    {
                        string sql_text = "INSERT INTO users (email, password, first_name, last_name, patronymic, contact, role_id)" +
                            "VALUES (@email, @password, @first_name, @last_name, @patronymic, @contact, @role_id)";

                        SqlCommand insert = new SqlCommand(sql_text, connection);
                        insert.CommandType = CommandType.Text;
                        insert.Parameters.AddWithValue("@email", email.Text);
                        insert.Parameters.AddWithValue("@password", GetHash(MD5.Create(), password.Text));
                        insert.Parameters.AddWithValue("@first_name", first_name.Text);
                        insert.Parameters.AddWithValue("@last_name", last_name.Text);
                        insert.Parameters.AddWithValue("@patronymic", patronymic.Text);
                        insert.Parameters.AddWithValue("@contact", contact.Text);
                        insert.Parameters.AddWithValue("@role_id", DEFAULT_ROLE_ID);
                        insert.ExecuteNonQuery();
                        Thread.Sleep(2000);
                        SqlCommand select_user = new SqlCommand("SELECT * FROM users WHERE email = @email and password = @password", connection);
                        select_user.CommandType = CommandType.Text;
                        select_user.Parameters.AddWithValue("@email", email.Text);
                        select_user.Parameters.AddWithValue("@password", GetHash(MD5.Create(), password.Text));
                        SqlDataReader reader_user = select_user.ExecuteReader();
                        while (reader_user.Read())
                        {
                            Session.RemoveAll();
                            Session.Add("id", reader_user["id"].ToString());
                            Session.Add("email", reader_user["email"].ToString());
                            Session.Add("first_name", reader_user["first_name"].ToString());
                            Session.Add("last_name", reader_user["last_name"].ToString());
                            Session.Add("patronymic", reader_user["patronymic"].ToString());
                            Session.Add("contact", reader_user["contact"].ToString());
                            Session.Add("role_id", reader_user["role_id"].ToString());
                            Response.Redirect("index.aspx?registration_success=true");
                        }
                    }
                }
                catch
                {
                    errors.Text = "Виникла помилка на стороні сервера.";
                    password.Text = password_repeat.Text = "";
                }
                finally
                {
                    connection.Close();
                }
            }
            else
            {
                errors.Text = "Паролі не співпадають!";
                password.Text = password_repeat.Text = "";
            }
        }
    }
}