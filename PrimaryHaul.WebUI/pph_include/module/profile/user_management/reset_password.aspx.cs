using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using PrimaryHaul.WebUI.App_Code;
using PrimaryHaul_WS;
namespace PrimaryHaul.WebUI.pph_include.module.profile.user_management
{
    public partial class reset_password : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            main_function PPHfunction = new main_function();
            PPHfunction.QueryExecuteNonQuery("update User_Profile set Passwd_Expired_Date='" + DateTime.Now + "', Passwd='" + PH_EncrptHelper.MD5Encryp("P@sswOrd") + "' WHERE UserID='" + PPHfunction.decodeBase64(Request.QueryString["Param"].ToString()) + "'");

            Response.Write("<script>alert('Password Reset Already');window.location.href='../../../.." + PPHfunction.decodeBase64(Request.QueryString["url"].ToString())+"';</script>");
        }
    }
}