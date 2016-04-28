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
        public static SqlDataReader get_allVendor(string strConnDB, string strName, string strCode, string strRole)
        {
            SqlConnection objConn = new SqlConnection();
            objConn.ConnectionString = strConnDB;
            objConn.Open();
            string strType = "";
            if (strRole.Substring(0, 1) == "B") { strType = "BH"; } else if (strRole.Substring(0, 1) == "F") { strType = "FZ"; } else { strType = "VD"; }
            SqlCommand cmd = new SqlCommand("usp_PrimaryHaul_Search_VendorName", objConn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Vendor_Name", SqlDbType.VarChar).Value = strName;
            cmd.Parameters.Add("@Vendor_Code", SqlDbType.VarChar).Value = strCode;
            cmd.Parameters.Add("@Vendor_Type", SqlDbType.VarChar).Value = strType;
            return cmd.ExecuteReader();
        }
    }
}
