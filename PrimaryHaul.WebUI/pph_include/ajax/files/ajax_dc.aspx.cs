using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using PrimaryHaul_WS;
using PrimaryHaul.WebUI.App_Code;
using PPH_SC;


namespace PrimaryHaul.WebUI.pph_include.ajax.files
{
    public partial class ajax_dc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.Form["varType"]))
            {
                if (Request.Form["varType"].ToString()=="delete")
                {
                    main_function PPHfunction = new main_function();
                    PPHfunction.QueryExecuteNonQuery("delete from  DC_Info where DC_NO='" + Request.Form["varID"].ToString() + "'");
                } 
            }
        }
    }
}