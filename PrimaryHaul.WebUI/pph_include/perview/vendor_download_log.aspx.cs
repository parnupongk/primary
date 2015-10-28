using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using PrimaryHaul.WebUI.App_Code;

namespace PrimaryHaul.WebUI.pph_include.perview
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

            string sql_detail = "Select Distinct T.Vendor_Code,V.Download_DateTime From Transportation T Left Outer Join vendor_download_log V on T.Vendor_Code=V.Vendor_Code and T.Year_Week_Upload='" + Request.QueryString["yw"].ToString() + "' and T.Year_Week_Upload=V.Tesco_Year_Week and Calc_date <> null or Calc_date <> '' Order by T.Vendor_Code,V.Download_DateTime Desc";
            SqlCommand rs_detail = new SqlCommand(sql_detail, objConn);
            obj_detail = rs_detail.ExecuteReader();
        }
    }
}