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
    public partial class AccountForm : System.Web.UI.Page
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

            if (!IsPostBack)
            {
                LoadUserInfo();
            }
        }

        public static string GetHash(MD5 md5, string input)
        {
            byte[] data = md5.ComputeHash(Encoding.UTF8.GetBytes(input));
            StringBuilder stringBuilder = new StringBuilder();
            for (int i = 0; i < data.Length; i++)
                stringBuilder.Append(data[i].ToString("x2"));
            return stringBuilder.ToString();
        }

        public int ChangeImage(int id, string imageName)
        {
            
            string queryStr = "UPDATE users SET image_name=@image_name WHERE id=@id";

            int result = 0;
            connection.Open();
            SqlCommand command = new SqlCommand(queryStr, connection);
            command.CommandType = CommandType.Text;
            command.Parameters.Add("@image_name", SqlDbType.VarChar, 100).Value = imageName;
            command.Parameters.Add("@id", SqlDbType.Int).Value = id;

            try
            {
                result = command.ExecuteNonQuery();
                Image1.ImageUrl = $"~/images/user/{imageName}";
            }
            catch { }
            finally
            {
                connection.Close();
            }
            return result;
        }

        protected void UpdateImage(object sender, EventArgs e)
        {
            Alert alert = new Alert();
            int user_id = int.Parse(Session["id"].ToString());
            string pattern = "user";
            string noImage = "default.png";
            var folderPath = Server.MapPath("images") + "\\user";
            string imageName = ImageLoader.SaveImage(ref alert, FileUpload1, folderPath, pattern, user_id, noImage);
            if (imageName != noImage)
            {
                ChangeImage(user_id, imageName);
            }
            
            msg.InnerHtml = alert.GetAlerts();
        }

        protected void ChangePassword(object sender, EventArgs e)
        {
            string pass = TextBox1.Text;
            string pass_repeat = TextBox2.Text;
            Alert alert = new Alert();

            if(pass == string.Empty)
            {
                alert.AddErrorAlert("Заповніть поле 'Новий пароль'!");
            }
            if (pass_repeat == string.Empty)
            {
                alert.AddErrorAlert("Заповніть поле 'Підтвердження паролю'!");
            }
            if (pass != pass_repeat)
            {
                alert.AddErrorAlert("Паролі не співпадають!");
            }
            if (alert.errorCounter > 0)
            {
                msg.InnerHtml = alert.GetAlerts();
                return;
            }
            try
            {
                connection.Open();
                SqlCommand select = new SqlCommand("UPDATE users SET password=@pass WHERE id=@user_id", connection);
                select.CommandType = System.Data.CommandType.Text;
                select.Parameters.AddWithValue("@user_id", int.Parse(Session["id"].ToString()));
                select.Parameters.AddWithValue("@pass", GetHash(MD5.Create(), pass));
                select.ExecuteNonQuery();
                LoadUserInfo();
            }
            catch
            {

            }
            finally
            {
                connection.Close();
            }
        }

        protected void LoadUserInfo()
        {
            try
            {
                connection.Open();
                SqlCommand select = new SqlCommand("SELECT * FROM users WHERE id=@user_id", connection);
                select.CommandType = CommandType.Text;
                select.Parameters.AddWithValue("@user_id", int.Parse(Session["id"].ToString()));
                SqlDataReader reader = select.ExecuteReader();
                reader.Read();

                first_name.Text = reader["first_name"].ToString();
                last_name.Text = reader["last_name"].ToString();
                patronymic.Text = reader["patronymic"].ToString();
                email.Text = reader["email"].ToString();
                contact.Text = reader["phone"].ToString();
                Image1.ImageUrl = $"~/images/user/{reader["image_name"].ToString()}";

                Session.RemoveAll();
                Session.Add("id", reader["id"].ToString());
                Session.Add("email", reader["email"].ToString());
                Session.Add("first_name", reader["first_name"].ToString());
                Session.Add("last_name", reader["last_name"].ToString());
                Session.Add("patronymic", reader["patronymic"].ToString());
                Session.Add("phone", reader["phone"].ToString());
                Session.Add("role_id", reader["role_id"].ToString());
                Session.Add("city_id", reader["city_id"].ToString());
            }
            catch
            {
            }
            finally
            {
                connection.Close();
            }
        }

        protected void UpdateUserInfo(object sender, EventArgs e)
        {
            Alert alert = new Alert();
            try
            {
                connection.Open();
                System.Data.SqlClient.SqlCommand select = new System.Data.SqlClient.SqlCommand("UPDATE users SET first_name=@first_name, " +
                    "last_name=@last_name, patronymic=@patronymic, email=@email, phone=@phone, city_id=@city_id WHERE id=@user_id", connection);
                select.CommandType = System.Data.CommandType.Text;
                select.Parameters.AddWithValue("@user_id", int.Parse(Session["id"].ToString()));
                select.Parameters.AddWithValue("@first_name", first_name.Text);
                select.Parameters.AddWithValue("@last_name", last_name.Text);
                select.Parameters.AddWithValue("@patronymic", patronymic.Text);
                select.Parameters.AddWithValue("@email", email.Text);
                select.Parameters.AddWithValue("@phone", contact.Text);
                select.Parameters.AddWithValue("@city_id", contact.Text);
                select.ExecuteNonQuery();
                alert.AddMessageAlert("Дані успішно оновлено.");
                LoadUserInfo();
            }
            catch
            {
                alert.AddErrorAlert("Помилка з’єдання до бази даних!");
            }
            finally
            {
                connection.Close();
                msg.InnerHtml = alert.GetAlerts();
            }           
        }

    }
}