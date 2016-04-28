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
    public partial class vender_Submit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            main_function PPHfunction = new main_function();
            cs_checkFiled getLast = new cs_checkFiled();
            string vnID = getLast.sql_getAjaxAnswer("SELECT VendorID FROM Vendor_Info order by VendorID desc");
            int m = Int32.Parse(vnID);
            string vendor_type = "";
            if (Request.Form["var04"].ToString().Substring(0, 1) == "B") { vendor_type = "BH"; } else if (Request.Form["var04"].ToString().Substring(0, 1) == "F") { vendor_type = "FZ"; } else { vendor_type = "VD"; }
            PPHfunction.QueryExecuteNonQuery("insert into Vendor_Info (VendorID, Vendor_TaxID, Vendor_Name_En, Vendor_Name_Th, StampTime, vendor_type) values ('" + (m + 1) + "', '" + Request.Form["var01"].ToString() + "','" + Request.Form["var02"].ToString() + "','" + Request.Form["var03"].ToString() + "','" + DateTime.Now + "','" + vendor_type + "')");           
        }
    }
}