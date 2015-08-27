using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace PrimaryHaul.WebUI
{
    public partial class masterDC : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
                DataTable dt = new DataTable("DC");
                dt.Columns.AddRange(new DataColumn[] {new DataColumn("dcNo"),new DataColumn("dcName"),new DataColumn("startDate") });
                dt.Rows.Add(dt.NewRow());
                gvDc.DataSource = dt;
                gvDc.DataBind();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            txtDcName.Text = PrimaryHaul_WS.PH_EncrptHelper.MD5Encryp(txtDcNo.Text);
        }
    }
}