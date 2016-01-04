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
    public partial class dc_EditSubmit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            main_function PPHfunction = new main_function();
            string dateEndUse;
            if(!string.IsNullOrEmpty(Request.Form["var03"] as string)){
            string[] arrDate = Request.Form["var03"].ToString().Split('/');
            dateEndUse = "'" + arrDate[2] + "-" + arrDate[1] + "-" + arrDate[0] + "'";
            }
            else{
                dateEndUse = "NULL";
            }
            //Response.Write("update DC_Info set DC_Name='" + Request.Form["var02"].ToString() + "', EndDate='" + dateEndUse + "' where DC_NO='" + Request.Form["var01"].ToString() + "'");
            PPHfunction.QueryExecuteNonQuery("update DC_Info set DC_Name='" + Request.Form["var02"].ToString() + "', EndDate=" + dateEndUse + ", dc_abbr='" + Request.Form["var04"].ToString() + "', DC_Flag='" + Request.Form["var05"].ToString() + "' where DC_NO='" + Request.Form["var01"].ToString() + "'");
        
        }
    }
}