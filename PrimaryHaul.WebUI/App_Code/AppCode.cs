using System;
using System.Collections.Generic;
using System.Web;
using System.Web.SessionState;
using System.Configuration;
using PrimaryHaul_WS;
namespace PrimaryHaul.WebUI
{
    public class AppCode
    {
        public static string strConnDB = ConfigurationManager.ConnectionStrings["PrimaryHaul_WS.ConnDB"].ToString();
        public static int GetDayofPasswdExp(System.Web.UI.Page page)
        {
            try
            {
                return page.Session[ConfigurationManager.AppSettings["PH_Day_PasswordExpired_Session"]] == null ? int.Parse(PH_DayofPasswrdExp.PH_DayOfExp_Sel(AppCode.strConnDB).ToString()) : int.Parse(page.Session[ConfigurationManager.AppSettings["PH_Day_PasswordExpired_Session"]].ToString());
            }
            catch (Exception ex)
            {
                throw new Exception("GetDayofPasswdExp >>" + ex.Message);
            }
        }

    }
}