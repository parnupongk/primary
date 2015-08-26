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
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try {
                PrimaryHaul_WSFlow.PHCore_Status status = PrimaryHaul_WSFlow.PHCore_Login.UserSignIn(AppCode.strConnDB, txtUserName.Text, txtPassword.Text);
                if (status.Status == PrimaryHaul_WSFlow.PHCore_Status.SignInStatus.Success)
                {
                    storeUser(status);
                    Response.Redirect("index.aspx?r=" + status.RoleId + "&id=" + PH_EncrptHelper.MD5Encryp(status.UserId), false);
                }
                else if (status.Status == PrimaryHaul_WSFlow.PHCore_Status.SignInStatus.PasswordExpired)
                {
                    storeUser(status);
                    Response.Redirect("changepassword.aspx?r=" + status.RoleId +"&p=" + PH_EncrptHelper.MD5Encryp(txtPassword.Text) +"&id="+ PH_EncrptHelper.MD5Encryp(status.UserId), false);
                }
            }
            catch(Exception ex)
            {
                lblErr.Text = ex.Message;
                PH_ExceptionManager.WriteError(ex.Message);
            }
        }

        private void storeUser(PrimaryHaul_WSFlow.PHCore_Status status)
        {
            try
            {
                
                PH_Utility.CreateCookie(PH_EncrptHelper.MD5Encryp(status.UserName), Response, ConfigurationManager.AppSettings["PH_NameUserCookie"], int.Parse(ConfigurationManager.AppSettings["PH_TimeUserCookie"]));
                PH_Utility.CreateCookie(PH_EncrptHelper.MD5Encryp(status.RoleId.ToString()), Response, ConfigurationManager.AppSettings["PH_RoleUserCookie"], int.Parse(ConfigurationManager.AppSettings["PH_TimeUserCookie"]));
                PH_Utility.CreateCookie(PH_EncrptHelper.MD5Encryp(status.Status.ToString()), Response, ConfigurationManager.AppSettings["PH_StatusUserCookie"], int.Parse(ConfigurationManager.AppSettings["PH_TimeUserCookie"]));
            }
            catch(Exception ex)
            {
                throw new Exception("storeUser >>" + ex.Message);
            }
        }
    }
}