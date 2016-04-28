using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using PrimaryHaul_WS;
using PrimaryHaul.WebUI.App_Code;

namespace PrimaryHaul.WebUI
{
    public partial class master_vender_delete : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            main_function PPHfunction = new main_function();
            PPHfunction.QueryExecuteNonQuery("delete from  Vendor_Group where VendorID='" + Request.QueryString["vdID"].ToString() + "'");
            PPHfunction.QueryExecuteNonQuery("delete from  Vendor_Info  where VendorID='" + Request.QueryString["vdID"].ToString() + "'");
            Response.Write("<script>alert('Delete Success !!');document.location.href='./master_vender.aspx?r=" + Request.QueryString["r"].ToString() + "&id=" + Request.QueryString["id"].ToString() + "&seName=" + Request.QueryString["seName"].ToString() + "&seCode=" + Request.QueryString["seCode"].ToString() + "';</script>"); 
        }
    }
}