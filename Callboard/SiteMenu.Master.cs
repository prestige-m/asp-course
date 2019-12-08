using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Callboard
{
    public partial class SiteMenu : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session.Count != 0)
                first_name.Text = Session["first_name"].ToString();
        }

        protected void SignOut(object sender, EventArgs e)
        {
            this.Session.RemoveAll();
            Response.Redirect("~/index.aspx");
        }
    }
}