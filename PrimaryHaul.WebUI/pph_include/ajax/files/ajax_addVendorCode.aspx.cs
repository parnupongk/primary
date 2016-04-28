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
    public partial class ajax_addVendorCode : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            main_function PPHfunction = new main_function();
            cs_checkFiled getLast = new cs_checkFiled();
            //string vnID = getLast.sql_getAjaxAnswer("SELECT VendorID FROM Vendor_Info  where Vendor_TaxID ='" + Request.Form["var02"].ToString() + "'");
            string vendor_type = "";
            if (Request.Form["var04"].ToString().Substring(0, 1) == "B") { vendor_type = "BH"; } else if (Request.Form["var04"].ToString().Substring(0, 1) == "F") { vendor_type = "FZ"; } else { vendor_type = "VD"; }
            string vnID = Request.Form["var02"].ToString();
            PPHfunction.QueryExecuteNonQuery("insert into Vendor_Group (VendorID, Vendor_Code, vendor_type) values ('" + vnID + "', '" + Request.Form["var01"].ToString() + "', '" + vendor_type + "')");
        
        }
    }
}