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
            Session["s_forceChangeMsg"] = "";
            try {
                PrimaryHaul_WSFlow.PHCore_Status status = PrimaryHaul_WSFlow.PHCore_Login.UserSignIn(AppCode.strConnDB, txtUserName.Text, txtPassword.Text);
                if (status.UserStatus == "D")
                {
                    lblErr.Text = "Please contact System Administrator";
                }
                else
                {
                    if (status.Status == PrimaryHaul_WSFlow.PHCore_Status.SignInStatus.Success)
                    {
                        storeUser(status);
                        Session["s_forceChange"] = "";
                        if (status.RoleId.ToString() == "VD")
                        {
                            Response.Redirect("report_venderlog.aspx?r=" + status.RoleId + "&id=" + status.UserId, false);
                        }
                        else if (status.RoleId.ToString() == "HL")
                        {
                            Response.Redirect("haulier_upload.aspx?r=" + status.RoleId + "&id=" + status.UserId, false);
                        }
                        else
                        {
                            Response.Redirect("index.aspx?r=" + status.RoleId + "&id=" + status.UserId, false);
                        }
                    }
                    else if (status.Status == PrimaryHaul_WSFlow.PHCore_Status.SignInStatus.PasswordExpired)
                    {
                        storeUser(status);
                        if (txtPassword.Text == "P@ssw0rd") { Session["s_forceChangeMsg"] = "password was reset. Please enter new password."; } else { Session["s_forceChangeMsg"] = "your password has expired. Please enter new password."; }
                        Session["s_forceChange"] = "changepassword.aspx?r=" + status.RoleId + "&p=" + PH_EncrptHelper.MD5Encryp(txtPassword.Text) + "&id=" + status.UserId;
                        Response.Redirect("changepassword.aspx?r=" + status.RoleId + "&p=" + PH_EncrptHelper.MD5Encryp(txtPassword.Text) + "&id=" + status.UserId, false);
                    }
                    else
                    {
                        lblErr.Text = "User Name or Password incorrect";
                    }
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