using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using PrimaryHaul_WS;

namespace PrimaryHaul_WSFlow
{
    public class PHCode_Menu
    {
        /// <summary>
        /// PHCode_Menu_SelByRole
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <param name="strRoleId"></param>
        /// <returns></returns>
        public static DataTable PHCode_Menu_SelByRole(string strConnDB,PHCore_Status.RoleID strRoleId)
        {
            try
            {
                return PH_MenuRole.PH_MenuRole_SelByRole(strConnDB, strRoleId.ToString());
            }
            catch(Exception ex)
            {
                throw new Exception("PHCode_Menu_SelByRole >>" + ex.Message);
            }
        }

    }
}
