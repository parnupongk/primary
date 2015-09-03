using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Linq;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Net;

namespace PrimaryHaul.WebUI.App_Code
{
    public class main_function
    {
        private SqlConnection objConn;
        private SqlCommand objCmd;
        private String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        public string encodeBase64(string txtValue)
        {
            return Convert.ToBase64String(Encoding.UTF8.GetBytes(txtValue));
        }

        public string decodeBase64(string txtValue)
        {
            return Encoding.UTF8.GetString(Convert.FromBase64String(txtValue));
        }

        public Boolean QueryExecuteNonQuery(String strSQL)
        {
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();

            try
            {
                objCmd = new SqlCommand();
                objCmd.Connection = objConn;
                objCmd.CommandType = CommandType.Text;
                objCmd.CommandText = strSQL;

                objCmd.ExecuteNonQuery();
                objConn.Close();
                objConn = null;
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}