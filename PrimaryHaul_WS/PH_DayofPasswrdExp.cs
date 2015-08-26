using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
namespace PrimaryHaul_WS
{
    public class PH_DayofPasswrdExp
    {
        /// <summary>
        /// PH_DayofExp_Insert
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <param name="iDayofExp"></param>
        /// <returns></returns>
        public static int PH_DayofExp_Insert(string strConnDB, int iDayofExp)
        {
            try
            {
                return SqlHelper.ExecuteNonQuery(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_DayofPasswdExp"
                    , new SqlParameter[] { new SqlParameter("@Day_Expired", iDayofExp) });
            }
            catch (Exception ex)
            {
                throw new Exception("PH_DayofExp_Insert >>" + ex.Message);
            }
        }

        public static int PH_DayOfExp_Sel(string strConnDB)
        {
            try {
                object rtn = SqlHelper.ExecuteScalar(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_DayofPasswdExp_Sel");
                return rtn == null || rtn == "" ? 0 : int.Parse(rtn.ToString());
            }
            catch (Exception ex)
            {
                throw new Exception("PH_DayOfExp_Sel >>" + ex.Message);
            }
        }

    }
}
