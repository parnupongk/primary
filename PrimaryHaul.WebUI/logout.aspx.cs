using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
namespace PrimaryHaul.WebUI
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PrimaryHaul_WS.PH_Utility.DeleteCookie(Response, ConfigurationManager.AppSettings["PH_NameUserCookie"]);
            PrimaryHaul_WS.PH_Utility.DeleteCookie(Response, ConfigurationManager.AppSettings["PH_RoleUserCookie"]);
            Response.Redirect("login.aspx", false);
        }
    }
}