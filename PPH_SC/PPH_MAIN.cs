using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Globalization;
using System.Threading;
using System.Threading.Tasks;

namespace PPH_SC
{
    public class PPH_MAIN
    {
        public static SqlDataReader get_yw(string strConnDB)
        {
            SqlConnection objConn = new SqlConnection();
            objConn.ConnectionString = strConnDB;
            objConn.Open();
            SqlCommand cmd_getYW = new SqlCommand("usp_PrimaryHaul_DateWeekInfoSel", objConn);
            cmd_getYW.CommandType = CommandType.StoredProcedure;
            return cmd_getYW.ExecuteReader();
        }

        public static SqlDataReader get_ywAll(string strConnDB)
        {
            SqlConnection objConn = new SqlConnection();
            objConn.ConnectionString = strConnDB;
            objConn.Open();
            SqlCommand cmd_ywAll = new SqlCommand("usp_PrimaryHaul_DateWeekInfoSelAll", objConn);
            cmd_ywAll.CommandType = CommandType.StoredProcedure;
            return cmd_ywAll.ExecuteReader();
        }
    }
}
