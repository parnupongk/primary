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

namespace PrimaryHaul.WebUI.App_Code
{
    public class cs_checkFiled
    {
        private SqlConnection objConn;
        private String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];

        public int sql_checkDuplicate(string sql_string)
        {
            int txt_return = 0;
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();
            DataTable obj_checkDuplicate = new DataTable();
            SqlDataAdapter rs_checkDuplicate = new SqlDataAdapter(sql_string, objConn);
            rs_checkDuplicate.Fill(obj_checkDuplicate);
            if (obj_checkDuplicate.Rows.Count > 0)
            {
                txt_return = 1;
            }
            objConn.Close();
            objConn = null;
            return txt_return;
        }

        public string sql_getAjaxAnswer(string sql_string)
        {
            string txt_return = "";
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();
            DataTable obj_getAjaxAnswer = new DataTable();
            SqlDataAdapter rs_getAjaxAnswer = new SqlDataAdapter(sql_string, objConn);
            rs_getAjaxAnswer.Fill(obj_getAjaxAnswer);
            if (obj_getAjaxAnswer.Rows.Count > 0)
            {
                txt_return = obj_getAjaxAnswer.Rows[0][0].ToString();
            }
            objConn.Close();
            objConn = null;
            return txt_return;
        }
    }
}