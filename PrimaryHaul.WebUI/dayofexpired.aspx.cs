using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using PrimaryHaul_WS;
namespace PrimaryHaul.WebUI
{
    public partial class dayofexpired : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try {
                if (!IsPostBack)
                {
                    txtDayofExpired.Text = AppCode.GetDayofPasswdExp(Page).ToString();
                }
            }
            catch(Exception ex)
            {
                lblErr.Text = ex.Message;
                PH_ExceptionManager.WriteError(ex.Message);
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (PH_DayofPasswrdExp.PH_DayofExp_Insert(AppCode.strConnDB, int.Parse(txtDayofExpired.Text)) > 0)
                    lblErr.Text = "Date of Expired has changed! ";
                Session[ConfigurationManager.AppSettings["PH_Day_PasswordExpired_Session"]] = txtDayofExpired.Text;
            }
            catch(Exception ex)
            {
                lblErr.Text = ex.Message;
                PH_ExceptionManager.WriteError(ex.Message);
            }
        }
    }
}