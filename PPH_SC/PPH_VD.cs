using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace PPH_SC
{
    public class PPH_VD
    {
        public static SqlDataReader get_allVendor(string strConnDB, string strName, string strCode)
        {
            SqlConnection objConn = new SqlConnection();
            objConn.ConnectionString = strConnDB;
            objConn.Open();
            SqlCommand cmd = new SqlCommand("usp_PrimaryHaul_Search_VendorName", objConn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Vendor_Name", SqlDbType.VarChar).Value = strName;
            cmd.Parameters.Add("@Vendor_Code", SqlDbType.VarChar).Value = strCode;
              
            return cmd.ExecuteReader();
        }
    }
}
