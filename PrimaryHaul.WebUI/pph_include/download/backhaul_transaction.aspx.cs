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
    public partial class backhaul_transaction : System.Web.UI.Page
    {
        public SqlDataReader obj_detail;
        public SqlConnection objConn;
        public String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        protected void Page_Load(object sender, EventArgs e)
        {
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();

            SqlCommand cmd_export = new SqlCommand("usp_BH_Transaction_Export", objConn);
            cmd_export.CommandType = CommandType.StoredProcedure;
            cmd_export.Parameters.Add("@Week", SqlDbType.VarChar).Value = Request.QueryString["yw"].ToString();
            obj_detail = cmd_export.ExecuteReader();

            Response.AddHeader("Content-Disposition", "attachment;filename=backhaul_transaction_" + Request.QueryString["yw"].ToString() + ".xls");
 
        }
    }
}