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
    public partial class haulier_edit_Submit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            main_function PPHfunction = new main_function();
            PPHfunction.QueryExecuteNonQuery("update Haulier_Info set Haulier_Name_En='" + Request.Form["var02"].ToString() + "', Haulier_Abbr='" + Request.Form["var03"].ToString() + "', StampTime='"+DateTime.Now+"' where Haulier_TaxID='" + Request.Form["var01"].ToString() + "'");
        
        }
    }
}