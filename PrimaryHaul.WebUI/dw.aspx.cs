using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PrimaryHaul_WS;
namespace PrimaryHaul.WebUI
{
    public partial class dw : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //TextBox1.Text = "201607".Substring(4, 2);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
           TextBox1.Text =  PH_EncrptHelper.MD5Decryp(TextBox1.Text);
        }
    }
}