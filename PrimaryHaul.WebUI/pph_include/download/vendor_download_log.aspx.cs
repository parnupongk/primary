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
    public partial class vendor_download_log : System.Web.UI.Page
    {
        public SqlDataReader obj_detail;
        public SqlConnection objConn;
        public String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        protected void Page_Load(object sender, EventArgs e)
        {
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();

            string sql_detail = "Select T.Vendor_Code,L.Download_DateTime,U.UserName From( select Distinct Vendor_Code,Year_Week_Upload from Transportation Where Year_Week_Upload='" + Request.QueryString["yw"].ToString() + "' and Calc_Date is not null) T Left Outer Join Vendor_Download_Log L on T.Vendor_Code = L.Vendor_Code  and T.Year_Week_Upload = L.Tesco_Year_Week and L.Tesco_Year_Week = '" + Request.QueryString["yw"].ToString() + "' Left Outer Join User_Profile U on U.UserID=L.Vendor_UserID Order by T.Vendor_Code Asc";
            SqlCommand rs_detail = new SqlCommand(sql_detail, objConn);
            obj_detail = rs_detail.ExecuteReader();

            Response.AddHeader("Content-Disposition", "attachment;filename=Vendor_download_log_" + Request.QueryString["yw"].ToString() + ".xls");
        }
    }
}