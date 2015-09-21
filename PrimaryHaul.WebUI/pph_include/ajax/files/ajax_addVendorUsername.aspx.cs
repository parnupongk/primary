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
    public partial class ajax_addVendorUsername : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            main_function PPHfunction = new main_function();
            if (Request.Form["var02"].ToString() != "")
            {
                string inID = Request.Form["var02"].ToString().Replace("||", "','");
                inID = inID.Replace("|", "'");
                string inIDCO = Request.Form["var03"].ToString().Replace("||", "','");
                inIDCO = inIDCO.Replace("|", "'");
                //Response.Write("update Vendor_Group set Vendor_UserName='" + Request.Form["var01"].ToString() + "' where VendorID in (" + inID + ") and Vendor_Code in (" + inIDCO + ")");
                PPHfunction.QueryExecuteNonQuery("update Vendor_Group set Vendor_UserName='" + Request.Form["var01"].ToString() + "' where VendorID in (" + inID + ") and Vendor_Code in (" + inIDCO + ")");
            }
        }
    }
}