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
    public partial class vd_download_log : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            main_function PPHfunction = new main_function();
            PPHfunction.QueryExecuteNonQuery("insert into Vendor_Download_Log (Vendor_UserID,Tesco_Year_Week,File_Name, Status,Download_DateTime, vendor_Code) values ('" + Request.Form["var01"].ToString() + "','" + Request.Form["var02"].ToString() + "','" + Request.Form["var03"].ToString() + "_" + Request.Form["var02"].ToString() + ".xls', 'Y', '" + DateTime.Now + "','" + Request.Form["var03"].ToString() + "')");
        
        }
    }
}