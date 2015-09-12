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

namespace PrimaryHaul.WebUI.pph_include.ajax.files
{
    public partial class dc_Submit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            main_function PPHfunction = new main_function();
            PPHfunction.QueryExecuteNonQuery("insert into DC_Info (DC_NO,DC_Name, UserID) values ('" + Request.Form["var01"].ToString() + "','" + Request.Form["var02"].ToString() + "', '0')");
        
        }
    }
}