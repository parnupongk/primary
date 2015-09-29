using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using PrimaryHaul.WebUI.App_Code;

namespace PrimaryHaul.WebUI.pph_include.download
{
    public partial class vendor_file : System.Web.UI.Page
    {
        public SqlDataReader obj_detail;
        public SqlConnection objConn;
        public String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        protected void Page_Load(object sender, EventArgs e)
        {
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();

            string sql_detail = "select top 1 Vendor_Info.Vendor_Name_En from Vendor_Group, Vendor_Info where Vendor_Group.VendorID=Vendor_Info.VendorID and Vendor_Group.Vendor_Code='" + Request.QueryString["VD"].ToString() + "'";
            SqlCommand rs_detail = new SqlCommand(sql_detail, objConn);
            obj_detail = rs_detail.ExecuteReader();
            obj_detail.Read();
            Response.AddHeader("Content-Disposition", "attachment;filename="+obj_detail[0].ToString()+".xls");
        }
    }
}