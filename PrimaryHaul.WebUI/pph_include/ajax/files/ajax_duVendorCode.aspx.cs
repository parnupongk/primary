using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using PrimaryHaul_WS;
using PrimaryHaul.WebUI.App_Code;

namespace PrimaryHaul.WebUI.pph_include.ajax.files
{
    public partial class ajax_duVendorCode : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            cs_checkFiled checkDuplicate = new cs_checkFiled();
            string vendor_type = "";
            if (Request.Form["var02"].ToString().Substring(0, 1) == "B") { vendor_type = "BH"; } else if (Request.Form["var02"].ToString().Substring(0, 1) == "F") { vendor_type = "FZ"; } else { vendor_type = "VD"; }
            int afterCheckDuplicate = checkDuplicate.sql_checkDuplicate("SELECT top 1 VendorID FROM Vendor_Group where Vendor_Code='" + Request.Form["var01"].ToString() + "' and vendor_type='" + vendor_type + "'");
            Response.Write(afterCheckDuplicate);
        }
    }
}