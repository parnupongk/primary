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
    public partial class report_sum : System.Web.UI.Page
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
            if (!string.IsNullOrEmpty(Request.QueryString["dc"] as string)) { sql_hl = "and DC_NO='" + Request.QueryString["dc"].ToString() + "' "; }
            string sql_detail = "select Vendor_Name,Haulier_Abbr,DC_No,Delivery_Location,Currency, " +
           "case when upper(RateType) like '%Box%' then sum(No_Of_QTY) end as Boxes,RateType, " +
           "case when upper(RateType) like '%Pallet%' then sum(No_Of_QTY) end as Pallets,  " +
           "case when upper(RateType) like '%Tray%' then sum(No_Of_QTY) end as Trays, " +
           "case when upper(RateType) like '%Cases%' then sum(No_Of_QTY) end as Cases,  " +
           " case when upper(RateType) like '%Load%' then sum(No_Of_QTY) end as Loads,  " +
           "sum(Rate_Per_unit*No_Of_Qty) as Cost , " +
           "sum(Total_Cost) as TotalCost, " +
           "sum(Total_Cost_Charging) as Total_Revenue, " +
           "sum(Total_Cost_Charging-(Total_Cost)) as Profit " +
           "from transportation " +
           "Where Year_Week_Upload='" + Request.QueryString["yw"].ToString() + "' " +
           "" + sql_hl + "" +
           "" + sql_vd + "" +
           //"and Vendor_Name<>'DUMMY' " +
           "and Calc_Date is not null Group by Vendor_Name,Haulier_Abbr,DC_No,Delivery_Location,Currency,RateType Order by Vendor_Name ";
            SqlCommand rs_detail = new SqlCommand(sql_detail, objConn);
            obj_detail = rs_detail.ExecuteReader();

            Response.AddHeader("Content-Disposition", "attachment;filename=Vendor_Cost_" + Request.QueryString["yw"].ToString() + ".xls");
        }
    }
}