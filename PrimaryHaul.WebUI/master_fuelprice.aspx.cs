using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using PrimaryHaul_WS;
using PrimaryHaul.WebUI.App_Code;

namespace PrimaryHaul.WebUI
{
    public partial class master_fuelprice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    cs_checkFiled getLast = new cs_checkFiled();
                    string frValue = getLast.sql_getAjaxAnswer("SELECT top 1 Fuel_Rate FROM Fuel_Rate_Default");
                    txtFuelRate.Text = frValue;
                }
            }
            catch (Exception ex)
            {
                lblErr.Text = ex.Message;
                PH_ExceptionManager.WriteError(ex.Message);
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                main_function PPHfunction = new main_function();
                if (PPHfunction.QueryExecuteNonQuery("update Fuel_Rate_Default set Fuel_Rate='" + txtFuelRate.Text + "'"))
                {
                    lblErr.Text = "";
                    Response.Write("<script>alert('Save Success');</script>");
                }
                    
            }
            catch (Exception ex)
            {
                lblErr.Text = ex.Message;
                PH_ExceptionManager.WriteError(ex.Message);
            }
        }
    }
}