using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Callboard
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                //txtCat.Items.Insert(3, txtCat.Text);
                //lblmsg.Text = "Item successfully added to category dropdown ";
                //lblmsg.CssClass = "alert alert-success pull-right";
                //string strJsSuccess = new StringBuilder
                //("$('#sample_modal').modal('hide');").ToString();
                //ScriptManager.RegisterClientScriptBlock
                //(this, this.GetType(), "Hide", strJsSuccess, true);
            }
        }
    }
}