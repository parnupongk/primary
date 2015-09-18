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
    public partial class update_status : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            main_function PPHfunction = new main_function();
            //Response.Write(Request.QueryString["force"].ToString());
            if (Request.QueryString["force"].ToString() == "Y")
            {
                PPHfunction.QueryExecuteNonQuery("update User_Profile set User_Status='" + Request.QueryString["status"].ToString() + "', Passwd_Expired_Date='" + DateTime.Now + "', Passwd='" + PH_EncrptHelper.MD5Encryp("P@ssw0rd") + "' WHERE UserID='" + Request.QueryString["id"].ToString() + "'");
            }
            else
            {
                PPHfunction.QueryExecuteNonQuery("update User_Profile set User_Status='" + Request.QueryString["status"].ToString() + "' WHERE UserID='" + Request.QueryString["id"].ToString() + "'");
            }
            Response.Write("<script>alert('Status Updated Success');window.location.href='../../../.." + PPHfunction.decodeBase64(Request.QueryString["url"].ToString())+"';</script>");
        }
    }
}