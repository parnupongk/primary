using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using PrimaryHaul_WS;
using PrimaryHaul_WSFlow;
namespace PrimaryHaul.WebUI
{
    public partial class changePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try {
                if (!IsPostBack)
                {

                    txtPasswordExpired.Text = DateTime.Now.AddDays(AppCode.GetDayofPasswdExp(Page)).ToString("dd/MM/yyyy");
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
                if (PH_EncrptHelper.MD5Decryp(Request["p"]) == txtPassword.Text)
                {
                    lblErr.Text = ConfigurationManager.AppSettings["PH_Error_PasswordExpired"];
                } else
                {
                    var rtn = PHCore_User.ChangePasswd(AppCode.strConnDB, Request["id"], txtPassword.Text, DateTime.ParseExact(txtPasswordExpired.Text, "dd/MM/yyyy", null));
                    if (rtn > 0) Response.Redirect("login.aspx",false);
                }
            }
            catch(Exception ex)
            {
                lblErr.Text = ex.Message;
                PH_ExceptionManager.WriteError(ex.Message);
            }
        }
    }
}