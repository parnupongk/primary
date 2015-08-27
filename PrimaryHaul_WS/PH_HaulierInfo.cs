using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

namespace PrimaryHaul_WS
{
    public class PH_HaulierInfo
    {
        /// <summary>
        /// PH_Haulier_SelAll
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <returns></returns>
        public static DataTable PH_Haulier_SelAll(string strConnDB)
        {
            try
            {
                DataSet  ds = SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_HaulierSelAll");

                return ds.Tables.Count > 0 ?ds.Tables[0]:null;
            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// PH_Haulier_SelByTaxId
        /// </summary>
        /// <param name="strConnDB"></param>
        /// <param name="strTaxId"></param>
        /// <returns></returns>
        public static string PH_Haulier_SelByTaxId(string strConnDB,string strTaxId)
        {
            try
            {
                object obj = SqlHelper.ExecuteScalar(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_HaulierSelByTaxId"
                    , new SqlParameter[] {new SqlParameter("@TaxId", strTaxId) });
                return obj == null ?"":obj.ToString();
            }
            catch(Exception ex)
            {
                throw new Exception("PH_Haulier_SelByTaxId >>" + ex.Message);
            }
        }
    }
}
