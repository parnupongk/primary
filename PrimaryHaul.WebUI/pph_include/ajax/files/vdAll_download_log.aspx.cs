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
using PrimaryHaul_WS;

namespace PrimaryHaul.WebUI.pph_include.ajax.files
{
    public partial class vdAll_download_log : System.Web.UI.Page
    {
        private SqlConnection objConn;
        private String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        protected void Page_Load(object sender, EventArgs e)
        {
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();

            main_function PPHfunction = new main_function();
            int i = 0;
            string istring = "|";
            string sql_list = "select Distinct vendor_code,vendor_name, (select top 1 count(Vendor_Download_Log.DownloadLogID) from Vendor_Download_Log where Vendor_Download_Log.Tesco_Year_Week=transportation.year_week_upload and Vendor_Download_Log.Vendor_UserID=" + Request.Form["var01"] + " and Vendor_Download_Log.File_Name=vendor_code+'_" + Request.Form["var02"].ToString() + ".xls') as statusDownload from transportation where year_week_upload='" + Request.Form["var02"] + "' and calc_date is not null and vendor_code in (select vendor_code from vendor_group where Vendor_UserName= (select UserName from User_Profile where UserID=" + Request.Form["var01"] + ") )";
            SqlCommand rs_list = new SqlCommand(sql_list, objConn);
            SqlDataReader obj_list = rs_list.ExecuteReader();
            while (obj_list.Read())
            {
                i++;
                PPHfunction.QueryExecuteNonQuery("insert into Vendor_Download_Log (Vendor_UserID,Tesco_Year_Week,File_Name, Status,Download_DateTime) values ('" + Request.Form["var01"].ToString() + "','" + Request.Form["var02"].ToString() + "','" + obj_list["vendor_code"].ToString() + "_" + Request.Form["var01"].ToString() + ".xls', 'Y', '" + DateTime.Now + "')");
                istring = istring+""+obj_list["vendor_code"].ToString() + "|";
            }
            obj_list.Close();
            Response.Write(i + "-" + istring);
        }
    }
}