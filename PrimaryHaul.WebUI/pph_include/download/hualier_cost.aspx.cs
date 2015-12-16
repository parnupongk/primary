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

            string sql_detail = "select Haulier_Abbr, DC_No, sum(Total_Cost_Charging) as Total_Revenue, sum(Total_Cost+Additional_Cost) as Total_Cost, CAST((((Sum(Total_Cost_Charging) - sum(Total_Cost) )/Sum(Total_Cost_Charging))*100) AS DEcimal(12,2)) as Percent_Profit from transportation where year_week_upload='" + Request.QueryString["yw"].ToString() + "' and Calc_Date is not null Group by Haulier_Abbr, DC_No";
            SqlCommand rs_detail = new SqlCommand(sql_detail, objConn);
            obj_detail = rs_detail.ExecuteReader();

            Response.AddHeader("Content-Disposition", "attachment;filename=Hualier_Cost_" + Request.QueryString["yw"].ToString() + ".xls");
        }
    }
}