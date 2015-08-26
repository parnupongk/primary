using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

namespace PrimaryHaul_WS
{
    public class PH_HaulierInfo
    {
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
