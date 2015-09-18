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
    public partial class masterDC : System.Web.UI.Page
    {

        public SqlConnection objConn;
        public String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        protected void Page_Load(object sender, EventArgs e)
        {
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();

            //if (!string.IsNullOrEmpty(Request.QueryString["DC_Date"] as string)) { txt_enddate.Text = Request.QueryString["DC_Date"].ToString(); }
            hid_DC_NO.Value = Request.QueryString["DC_NO"];
            urlHidden.Value = HttpContext.Current.Request.Url.AbsolutePath+"?r="+Request.QueryString["r"].ToString()+"&id="+Request.QueryString["id"].ToString();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            main_function PPHfunction = new main_function();
            string dateEndUse = "NULL";
            if(txt_enddate.Text!="")
            { 
                string[] arrDate = txt_enddate.Text.Split('/');
                dateEndUse = "'"+arrDate[2] + "-" + arrDate[1] + "-" + arrDate[0]+"'";
            }
            PPHfunction.QueryExecuteNonQuery("update DC_Info set EndDate=" + dateEndUse + " where DC_NO='" + hid_DC_NO.Value + "'");
            Response.Write("<script>alert('Submit Success');window.location.href='" + urlHidden.Value + "';</script>");
        
        }
    }
}