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
using PPH_SC;

namespace PrimaryHaul.WebUI
{
    public partial class masterDC : System.Web.UI.Page
    {
        public SqlConnection objConn;
        public String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        protected void Page_Load(object sender, EventArgs e)
        {
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();

            urlHidden.Value = HttpContext.Current.Request.Url.AbsolutePath+"?r="+Request.QueryString["r"].ToString()+"&id="+Request.QueryString["id"].ToString();
        }

    }

    
}