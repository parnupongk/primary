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
    public partial class report_kpi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.AddHeader("Content-Disposition", "attachment;filename=kpi_" + Request.QueryString["week"].ToString() + ".xls");
        }
    }
}