 using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

namespace PrimaryHaul_WS
{
    public class PH_MenuInfo
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <returns>Menu_InfoDataTable or null </returns>
        public static AppCode_DS.PHDS_Menu.Menu_InfoDataTable PH_MenuInfo_SelectAll(string strConnDB)
        {
            try
            {

                DataSet ds = SqlHelper.ExecuteDataset(strConnDB,CommandType.StoredProcedure  ,"sp_menuinfo_selectall");
                return (ds.Tables.Count > 0) ? (AppCode_DS.PHDS_Menu.Menu_InfoDataTable)ds.Tables[0] :null;
            }
            catch (Exception ex)
            {
                throw new Exception("PH_MenuInfo_SelectAll >>" + ex.Message);
            }
        }


        /*
        public static string PH_MenuInfo_Insert(string strConnDB, AppCode_DS.PHDS_Menu.Menu_InfoRow drMenuInfo)
        {
            try
            {
                return SqlHelper.ExecuteNonQueryTypedParams(strConnDB, "sp_menuinfo_insert", drMenuInfo).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception("PH_MenuInfo_Insert >>" + ex.Message);
            }
        }


        public static string PH_MenuInfo_Delete(string strConnDB, AppCode_DS.PHDS_Menu.Menu_InfoRow drMenuInfo)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, "sp_userprofile_delete", new SqlParameter[] { new SqlParameter("@UserID", drMenuInfo.UserID) }).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception("PH_MenuInfo_Delete >>" + ex.Message);
            }
        }


        public static string PH_MenuInfo_Update(string strConnDB, AppCode_DS.PHDS_Menu.Menu_InfoRow drMenuInfo)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, "sp_userprofile_update"
                    , new SqlParameter[] {new SqlParameter("@UserID", drProfile.UserID)
                                        ,new SqlParameter("@UserType",drProfile.UserType)
                                        }).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception("PH_MenuInfo_Update >>" + ex.Message);
            }
        }*/

    }
}
