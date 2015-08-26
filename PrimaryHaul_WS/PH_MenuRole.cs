using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

namespace PrimaryHaul_WS
{
    public class PH_MenuRole
    {
        /// <summary>
        /// PH_MenuRole_SelByRole
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <param name="strRoleId"></param>
        /// <returns></returns>
        public static DataTable PH_MenuRole_SelByRole(string strConnDB,string strRoleId)
        {
            try
            {

                DataSet ds = SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_Menu_SelByRole"
                    ,new SqlParameter[] {new SqlParameter("@RoldID",strRoleId) } );
                return (ds.Tables.Count > 0) ? ds.Tables[0] : null;
            }
            catch (Exception ex)
            {
                throw new Exception("PH_MenuRole_SelByRole >>" + ex.Message);
            }
        }
    }
}
