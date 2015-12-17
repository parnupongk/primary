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
    public partial class ajax_vendorDeleteUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            main_function PPHfunction = new main_function();
            string varDelete = Request.Form["var01"].ToString();
            //Response.Write(varDelete);
            string[] arrDelete = varDelete.Split('|');
            //Response.Write(arrDelete.Length);
            for (int i = 1; i < arrDelete.Length; i++)
            {
                string[] sqlDelete = arrDelete[i].Split('-');
                PPHfunction.QueryExecuteNonQuery("delete From Vendor_Group Where VendorID='" + sqlDelete[0] + "'  and Vendor_Code='" + sqlDelete[1] + "'");
                //Response.Write("delete From Vendor_Group Where VendorID='" + sqlDelete[0] + "'  and Vendor_Code='" + sqlDelete[1] + "'");
            }
        }
    }
}