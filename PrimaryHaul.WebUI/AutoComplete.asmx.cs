using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using PrimaryHaul_WS;
namespace PrimaryHaul.WebUI
{
    /// <summary>
    /// Summary description for AutoComplete
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class AutoComplete : System.Web.Services.WebService
    {

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat =System.Web.Script.Services.ResponseFormat.Json) ]
        public string[] GetVendorCode(string prefixText)
        {
            DataTable dt = PH_UserVendor.PH_UserVendor_SelectAll(AppCode.strConnDB);
            DataView dv = dt.DefaultView;
            dv.RowFilter = new System.Text.StringBuilder(" vendor_code like '%" + prefixText + "%'").ToString();
             
            List<string> items = new List<string>(dv.Count);

            for (int i = 0; i < dv.Count; i++)
            {
                string strName = dv[i]["vendor_code"].ToString() + "-" + dv[i]["Vendor_Name_en"].ToString();
                items.Add(strName);
            }
            return items.ToArray();
        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public string[] GetHaulierCode(string prefixText)
        {
            DataTable dt = PH_HaulierInfo.PH_Haulier_SelAll(AppCode.strConnDB);
            List<string> items = new List<string>(dt.Rows.Count);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string strName = dt.Rows[i]["haulier_taxid"].ToString() +"-" + dt.Rows[i]["haulier_name_en"].ToString() + "-" + dt.Rows[i]["haulier_name_th"].ToString();
                items.Add(strName);
            }
            return items.ToArray();
        }

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }
    }
}
