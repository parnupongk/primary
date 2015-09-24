using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

namespace PrimaryHaul_WS
{
    public class PH_HaulierUpload
    {
        public static DataTable PH_HaulierUp_SelAll(string strConnDB)
        {
            try
            {
                DataSet ds = SqlHelper.ExecuteDataset(strConnDB, CommandType.StoredProcedure, "usp_PrimaryHaul_HaulierUpSelectAll");

                return ds.Tables[0];
            }
            catch(Exception ex)
            {
                throw new Exception("PH_HaulierUp_SelAll >> " + ex.Message);
            }
        }
    }
}
