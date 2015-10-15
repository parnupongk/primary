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

namespace PrimaryHaul.WebUI
{
    public partial class report_finance : System.Web.UI.Page
    {
        public string sql_yw = "select B.WK_ID,B.Tesco_Year,B.Tesco_Week,B.Between_Date  from ( Select Wk_ID,Tesco_Year,Tesco_Week,Between_DAte From date_week_info where period_startdate <='" + DateTime.Now + "' and period_Enddate >='" + DateTime.Now + "' )A ,date_week_info B Where B.Wk_ID<=A.Wk_ID Order by B.Wk_ID  Desc";
        public string sql_hl = "select * from Haulier_Info order by Haulier_Name_En asc";
        public string sql_vd = "select * from Vendor_Info order by Vendor_Name_En asc";
        public string sql_dc = "select * from DC_Info order by DC_Name asc";
        public SqlConnection objConn;
        public String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        protected void Page_Load(object sender, EventArgs e)
        {
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();

            

            
            
           
            
            
            
        }
    }
}