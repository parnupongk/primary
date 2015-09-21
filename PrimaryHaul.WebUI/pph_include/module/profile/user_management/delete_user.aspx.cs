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
    public partial class delete_user : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            main_function PPHfunction = new main_function();

            PPHfunction.QueryExecuteNonQuery("delete from User_Profile WHERE UserID='" + PPHfunction.decodeBase64(Request.QueryString["Param"].ToString()) + "'");
            Response.Write("<script>alert('Delete Success');window.location.href='../../../.." + PPHfunction.decodeBase64(Request.QueryString["url"].ToString()) + "';</script>");
        
        }
    }
}