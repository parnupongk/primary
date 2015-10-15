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
    public partial class report_summary : System.Web.UI.Page
    {
        public SqlDataReader obj_detail;
        public SqlConnection objConn;
        public String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        protected void Page_Load(object sender, EventArgs e)
        {
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();
            string sql_hl = "";
            string sql_vd = "";
            if (!string.IsNullOrEmpty(Request.QueryString["hl"] as string)) { sql_hl = "and Haulier_Abbr='" + Request.QueryString["hl"].ToString() + "' "; }
            if (!string.IsNullOrEmpty(Request.QueryString["vd"] as string)) { sql_vd = "and Vendor_Code in (select Vendor_Code from Vendor_Group where VendorID='" + Request.QueryString["vd"].ToString() + "') "; }
            string sql_detail = "select substring(Year_Week_Upload,1,4) as Year,substring(Year_Week_Upload,5,2) as Week," +
            "rc_tesco_period,Vendor_Code,Vendor_Name,Haulier_Abbr, " +
            "sum(Total_Cost_Charging) as Accrued_Revenue, " +
            "sum(Total_Cost_Charging) as Total_Revenue, " +
            "sum(total_Cost) as Accrued_Cost , " +
            "sum(total_Cost+Additional_Cost) as Total_Cost " +
                //"--sum((Total_Cost_Charging-(total_Cost+Additional_Cost))*100)/(total_Cost+Additional_Cost))) as Profit"+
            "from transportation " +
            "Where Year_Week_Upload='" + Request.QueryString["yw"].ToString() + "' " +
            "" + sql_hl + "" +
            "" + sql_vd + "" +
            "Group by substring(Year_Week_Upload,1,4) ,substring(Year_Week_Upload,5,2), " +
            "rc_tesco_period,Vendor_Code,Vendor_Name,Haulier_Abbr";
            SqlCommand rs_detail = new SqlCommand(sql_detail, objConn);
            obj_detail = rs_detail.ExecuteReader();
            obj_detail.Read();
            Response.AddHeader("Content-Disposition", "attachment;filename=Tesco_Finance_Report_Summary_" + Request.QueryString["yw"].ToString() + ".xls");
        }
    }
}