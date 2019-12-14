using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Callboard
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [System.Web.Services.WebMethod]
        public static string GetCurrentTime(string name)
        {
            return "Hello " + name + Environment.NewLine + "The Current Time is: "
                + DateTime.Now.ToString();
        }

        [WebMethod()]
        [System.Web.Script.Services.ScriptMethod]
        public static List<City> GetCitiesInRegion(int regionID)
        {
            CityService service = new CityService();
            return service.GetCitiesInRegion(regionID);
        }
    }
}