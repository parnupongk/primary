using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Owin.Security;
using System.Data;
using System.Data.SqlClient;
using PrimaryHaul_WS;
namespace PrimaryHaul_WSFlow
{
    public class PHCore_Login
    {
        public static PHCore_Status UserSignIn(string strConnDB, string strUserName, string strPassword)
        {
            try
            {
                PHCore_Status eStatus = new PHCore_Status();
                DataTable dtUser = PH_UserProfile.PH_UserProfile_SigIn(strConnDB, strUserName, PH_EncrptHelper.MD5Encryp( strPassword));
                if (dtUser != null && dtUser.Rows.Count > 0)
                {
                    DateTime dtPassExpired = (DateTime)dtUser.Rows[0]["Passwd_Expired_Date"];
                    if (DateTime.Now > dtPassExpired) eStatus.Status = PHCore_Status.SignInStatus.PasswordExpired;
                    else eStatus.Status = PHCore_Status.SignInStatus.Success;


                    eStatus.UserId = dtUser.Rows[0]["userid"].ToString();
                    eStatus.UserName = dtUser.Rows[0]["username"].ToString();
                    eStatus.RoleId =  (PHCore_Status.RoleID)Enum.Parse( typeof(PHCore_Status.RoleID),dtUser.Rows[0]["roleid"].ToString() ,true);
                }
                else {
                    eStatus.Status = PHCore_Status.SignInStatus.Failure;
                }
                //eStatus = Microsoft.AspNet.Identity.Owin.SignInStatus.Success;
                return eStatus;

            }
            catch(Exception ex)
            {
                throw new Exception("UserSignIn >> " + ex.Message);
            }
        }

    }
}
