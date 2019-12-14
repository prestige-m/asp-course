using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Callboard
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService]
    public class CityService : System.Web.Services.WebService
    {
        [WebMethod()]
        public List<City> GetCitiesInRegion(int regionID)
        {
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand cmd = new SqlCommand(
                "SELECT * FROM cities WHERE region_id=@RegionID", connection);

            cmd.Parameters.Add(new SqlParameter("@RegionID", SqlDbType.Int)).Value = regionID;

            List<City> cities = new List<City>();
            try
            {
                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    cities.Add(new City(reader["id"].ToString(), reader["name"].ToString()));
                }
                reader.Close();
            }
            catch
            {
                throw new ApplicationException("Помилка данних!");
            }
            finally
            {
                connection.Close();
            }
            return cities;
        }
    }

}