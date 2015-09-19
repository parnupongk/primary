using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using PrimaryHaul_WS;
using PrimaryHaul_WSFlow;
namespace PrimaryHaul.WebUI
{
    public partial class Site : System.Web.UI.MasterPage
    {
        private PHCore_Status eStatus;
        protected static string GetUserName(HttpRequest request)
        {
            string strUserName = "";
            strUserName = PH_Utility.GetCookie(request, ConfigurationManager.AppSettings["PH_NameUserCookie"]);
            return strUserName == "" ? strUserName : PH_EncrptHelper.MD5Decryp(strUserName);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            if (!string.IsNullOrEmpty(Session["s_forceChange"] as string))
            {
                if (HttpContext.Current.Request.Url.AbsolutePath.Substring(HttpContext.Current.Request.Url.AbsolutePath.Length - 19, 19) != "changepassword.aspx")
                {
                    Response.Redirect(Session["s_forceChange"].ToString(), false);                   
                }
            }
            if( !IsPostBack )
            {
                //lnkChangePasswd.HRef = "changepassword.aspx?" + Request.QueryString;
                //lnkDayofExpired.HRef = "dayofexpired.aspx?" + Request.QueryString;
                
                if (PH_Utility.GetCookie(Request, ConfigurationManager.AppSettings["PH_NameUserCookie"]) == "" && PH_Utility.GetCookie(Request, ConfigurationManager.AppSettings["PH_RoleUserCookie"]) == "")
                {
                    Response.Redirect("login.aspx", false);
                }
                else if (Request["id"] == null) Response.Redirect("logout.aspx", false);
                else
                {
                    eStatus = new PHCore_Status();
                    string strRoleId = PH_EncrptHelper.MD5Decryp(PH_Utility.GetCookie(Request, ConfigurationManager.AppSettings["PH_RoleUserCookie"]));
                    if (strRoleId != "")
                        eStatus.RoleId = (PHCore_Status.RoleID)Enum.Parse(typeof(PHCore_Status.RoleID), strRoleId, true);

                    GenMenu();

                }
            }*/
        }

        private void GenMenu()
        {
            try
            {
                DataTable dtMenu = PHCode_Menu.PHCode_Menu_SelByRole(AppCode.strConnDB, eStatus.RoleId);
                foreach( Control ctr in this.Controls )
                {
                    if (ctr.GetType().Name == "HtmlAnchor")
                    {
                        var results = (from m in dtMenu.AsEnumerable()
                                        where m.Field<string>("Menu_Name") == ((System.Web.UI.HtmlControls.HtmlAnchor)ctr).Name
                                       select m).FirstOrDefault();

                        if (results != null && results["Menu_Name"].ToString() != "")
                        {
                            ((System.Web.UI.HtmlControls.HtmlAnchor)ctr).Visible = true;
                            ((System.Web.UI.HtmlControls.HtmlAnchor)ctr).HRef += Request.QueryString;
                        }
                        else
                            ((System.Web.UI.HtmlControls.HtmlAnchor)ctr).Visible = false;

                        //lbl.Text += results["Menu_Name"];
                    }
                }
            }
            catch(Exception ex)
            {
                PH_ExceptionManager.WriteError(ex.Message);
            }
        }
    }
}