using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using PrimaryHaul.WebUI.App_Code;

namespace PrimaryHaul.WebUI
{
    public partial class user_management : System.Web.UI.Page
    {
        public string txtType = "";
        public string txtText = "";
        public main_function PPHfunction = new main_function();
        public SqlDataReader obj_usertype;
        public SqlDataReader obj_listuser;
        public SqlConnection objConn;
        public String strConnString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        protected void Page_Load(object sender, EventArgs e)
        {
            objConn = new SqlConnection();
            objConn.ConnectionString = strConnString;
            objConn.Open();

            string sql_usertype = "select distinct RoleID, Group_Menu from Menu_Role where Group_Menu+RoleID not in ('TESCOHL', 'TESCOVD') order by RoleID asc";
            SqlCommand rs_usertype = new SqlCommand(sql_usertype, objConn);
            obj_usertype = rs_usertype.ExecuteReader();

            if (!string.IsNullOrEmpty(Request.QueryString["search_usertype"])) { txtType = Request.QueryString["search_usertype"]; }
            if (!string.IsNullOrEmpty(Request.QueryString["search_text"])) { txtText = "and UserName like '%"+Request.QueryString["search_text"]+"%'"; }
            
        }
    }
}