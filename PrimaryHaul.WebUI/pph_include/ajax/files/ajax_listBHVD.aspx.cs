using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using PrimaryHaul_WS;
using PrimaryHaul.WebUI.App_Code;
using PPH_SC;

namespace PrimaryHaul.WebUI.pph_include.ajax.files
{
    public partial class ajax_listBHVD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
            Response.Write("<select class=\"form-control\" style=\"width:100%;\" id=\"" + Request.Form["var03"].ToString() + "\" name=\"" + Request.Form["var03"].ToString() + "\">");
            SqlConnection objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();
            string[] adStart = Request.Form["var01"].ToString().Split('/');
            string[] adEnd = Request.Form["var02"].ToString().Split('/');
            SqlCommand cmd_getYW = new SqlCommand("usp_BH_Vendor_Select_FromTransaction", objConn);
            cmd_getYW.CommandType = CommandType.StoredProcedure;
            cmd_getYW.Parameters.AddWithValue("@ApptDate_Start", "" + adStart[2] + "-" + adStart[1] + "-" + adStart[0] + "");
            cmd_getYW.Parameters.AddWithValue("@ApptDate_End", "" + adEnd[2] + "-" + adEnd[1] + "-" + adEnd[0] + "");
            SqlDataReader obj_vd = cmd_getYW.ExecuteReader();
            while (obj_vd.Read())
            {
                Response.Write("<option value=\"" + obj_vd["vendor_name"] + "\">" + obj_vd["vendor_name"] + "</option>");
            } obj_vd.Close();
            Response.Write("</select>");
            objConn.Close();
            objConn = null;
        }
    }
}