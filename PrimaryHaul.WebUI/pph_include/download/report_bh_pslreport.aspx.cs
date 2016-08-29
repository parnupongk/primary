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

namespace PrimaryHaul.WebUI.pph_include.download
{
    public partial class report_bh_pslreport : System.Web.UI.Page
    {
        public string sql_yw = "Select Tesco_Year+Tesco_Week as dateweek ,Date_Week_Info.* From Date_Week_Info where Tesco_Year+Tesco_Week <(select Tesco_Year+Tesco_Week from Date_Week_Info where Period_StartDate < =Convert(varchar, Getdate(),111) and Period_EndDate >= Convert(varchar, Getdate(),111)) order by Tesco_Year+Tesco_week Desc";
        public string sql_dc = "Select dc_no,dc_name,dc_abbr From DC_Info Where DC_Abbr is Not null and EndDate is null Order by DC_No Asc";
        public SqlConnection objConn;
        public String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        protected void Page_Load(object sender, EventArgs e)
        {
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();
            Response.AppendHeader("content-disposition", "attachment; filename=report_bh_psl_" + Request.QueryString["wkstart"].ToString() + "_to_" + Request.QueryString["wkend"].ToString() + ".xls");
        
        }
    }
}