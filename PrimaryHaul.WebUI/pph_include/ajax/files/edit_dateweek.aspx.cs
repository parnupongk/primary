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
    public partial class edit_dateweek : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            main_function PPHfunction = new main_function();
            string strS, strE, strBetweenS, strBetweenE, strBetween;
            if (!string.IsNullOrEmpty(Request.Form["var01"] as string)) { string[] arrSDate = Request.Form["var01"].ToString().Split('/'); strS = "'" + arrSDate[2] + "-" + arrSDate[1] + "-" + arrSDate[0] + "'"; strBetweenS = arrSDate[0] + " " + PPHfunction.chrShortMonth(arrSDate[1]) + " " + arrSDate[2].Substring(2, 2); } else { strS = "NULL"; strBetweenS = ""; }
            if (!string.IsNullOrEmpty(Request.Form["var02"] as string)) { string[] arrESDate = Request.Form["var02"].ToString().Split('/'); strE = "'" + arrESDate[2] + "-" + arrESDate[1] + "-" + arrESDate[0] + "'"; strBetweenE = arrESDate[0] + " " + PPHfunction.chrShortMonth(arrESDate[1]) + " " + arrESDate[2].Substring(2, 2); } else { strE = "NULL"; strBetweenE = ""; }
            strBetween = strBetweenS + " - " + strBetweenE;
            PPHfunction.QueryExecuteNonQuery("update Date_Week_Info set Period_StartDate=" + strS + ", Period_EndDate=" + strE + ", Between_Date='" + strBetween + "', Tesco_Year='" + Request.Form["var04"].ToString() + "', Tesco_Week='" + Request.Form["var05"].ToString() + "', Testco_FY='" + Request.Form["var06"].ToString() + "' where Wk_ID='" + Request.Form["var03"].ToString() + "'");
        
        }
    }
}