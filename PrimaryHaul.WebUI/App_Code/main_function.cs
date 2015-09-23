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

        public string chrShortMonth(string txtValue)
        {
            string txtReturn="";
            if (txtValue.Length == 1) { txtValue = "0" + txtValue; }
            if (txtValue == "01") { txtReturn = "Jan"; }
            if (txtValue == "02") { txtReturn = "Feb"; }
            if (txtValue == "03") { txtReturn = "Mar"; }
            if (txtValue == "04") { txtReturn = "Apr"; }
            if (txtValue == "05") { txtReturn = "May"; }
            if (txtValue == "06") { txtReturn = "Jun"; }
            if (txtValue == "07") { txtReturn = "Jul"; }
            if (txtValue == "08") { txtReturn = "Aug"; }
            if (txtValue == "09") { txtReturn = "Sep"; }
            if (txtValue == "10") { txtReturn = "Oct"; }
            if (txtValue == "11") { txtReturn = "Nov"; }
            if (txtValue == "12") { txtReturn = "Dec"; }
            return txtReturn;
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