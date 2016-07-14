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
    public partial class hualier_cost : System.Web.UI.Page
    {
        public SqlDataReader obj_detail;
        public SqlConnection objConn;
        public String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        protected void Page_Load(object sender, EventArgs e)
        {
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();

            string sql_detail = "Select Haulier_Abbr,DC_No,DC_Abbr,Total_Revenue,Total_Cost, (Total_Revenue-Total_Cost) as Profit ,Case When Total_Revenue=0 Then -100 Else Cast(((Total_Revenue-Total_Cost)/Total_Revenue)*100 AS DEcimal(12,2)) End as Percent_Profit From (select Haulier_Abbr, DC_No,Case When PO_No<>'DOC' Then DC_Abbr Else Collection_point End As DC_Abbr,isnull(sum(Total_Cost_Charging),0) as Total_Revenue, isnull(sum(Total_Cost),0) as Total_Cost from transportation where year_week_upload between '" + Request.QueryString["yw"].ToString() + "' and '" + Request.QueryString["ywend"].ToString() + "' and Calc_Date is not null Group by Haulier_Abbr, DC_No , Case When PO_No<>'DOC' Then DC_Abbr Else Collection_point End) A order by Haulier_Abbr Asc";
            SqlCommand rs_detail = new SqlCommand(sql_detail, objConn);
            obj_detail = rs_detail.ExecuteReader();

            Response.AddHeader("Content-Disposition", "attachment;filename=Hualier_Cost_" + Request.QueryString["yw"].ToString() + "to" + Request.QueryString["ywend"].ToString() + ".xls");
        }
    }
}