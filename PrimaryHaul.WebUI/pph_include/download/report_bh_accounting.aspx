<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="report_bh_accounting.aspx.cs" Inherits="PrimaryHaul.WebUI.pph_include.download.report_bh_accounting" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="System.Linq"%>
<%@ Import Namespace="System.Collections.Generic"%>
<!DOCTYPE html>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
<% 
    string str_wkstart = ""; if (!string.IsNullOrEmpty(Request.QueryString["wkstart"] as string)) { str_wkstart = Request.QueryString["wkstart"].ToString(); }
    string str_wkend = ""; if (!string.IsNullOrEmpty(Request.QueryString["wkend"] as string)) { str_wkend = Request.QueryString["wkend"].ToString(); }
    string str_dc = "0"; if (!string.IsNullOrEmpty(Request.QueryString["dc"] as string)) { str_dc = Request.QueryString["dc"].ToString(); }
    string str_vd = "ALL"; if (!string.IsNullOrEmpty(Request.QueryString["vd"] as string)) { str_vd = Request.QueryString["vd"].ToString(); } 
%>
<% if(Convert.ToInt32(str_wkstart) <= Convert.ToInt32(str_wkend)){ int i;%>

        <table class="table table-bordered">
        <tr style="background-color:#9bbb59;">
            <td style="text-align:center;" colspan="3">&nbsp;</td>
            <% for(i=Convert.ToInt32(str_wkstart);i<=Convert.ToInt32(str_wkend);i++){ %>
                <td style="text-align:center;" colspan="3">WK<%=Convert.ToString(i).Substring(Convert.ToString(i).Length - 2,2)%></td>
            <% } %>
        </tr>
        <tr style="background-color:#9bbb59;">
            <td style="text-align:center;">DC</td>
            <td style="text-align:center;">Vendor</td>
            <td style="text-align:center;width:500px;">Vendor Name</td>
            <% for(i=Convert.ToInt32(str_wkstart);i<=Convert.ToInt32(str_wkend);i++){ %>
                <td style="text-align:center;">Load</td>
                <td style="text-align:center;">Case</td>
                <td style="text-align:center;">Bath</td>
            <% } %>
        </tr>
        <%                
               DataTable dt = new DataTable();
               DataRow dr;
               dt.Columns.Add("Week");
               dt.Columns.Add("DC");
               dt.Columns.Add("Vendor");
               dt.Columns.Add("VendorName");
               dt.Columns.Add("Load", typeof(Double));
               dt.Columns.Add("Case", typeof(Double));
               dt.Columns.Add("Bath", typeof(Double));
               SqlCommand rs_dcrow = new SqlCommand("usp_BH_Accounting", objConn); rs_dcrow.CommandType = CommandType.StoredProcedure; rs_dcrow.Parameters.AddWithValue("@Week_Start", str_wkstart); rs_dcrow.Parameters.AddWithValue("@Week_End", str_wkend); rs_dcrow.Parameters.AddWithValue("@DC_No", str_dc); ; rs_dcrow.Parameters.AddWithValue("@Vendor_Name", str_vd); SqlDataReader obj_dcrow = rs_dcrow.ExecuteReader(); while (obj_dcrow.Read())
               {
                   dr = dt.NewRow();
                   decimal doble_load = 0, doble_case = 0, doble_bath = 0;
	               if (obj_dcrow["LoadRcvd"].ToString() != "") { doble_load = Convert.ToDecimal(obj_dcrow["LoadRcvd"].ToString()); }
	               if (obj_dcrow["CaseRcvd"].ToString() != "") { doble_case = Convert.ToDecimal(obj_dcrow["CaseRcvd"].ToString()); }
	               if (obj_dcrow["BHT"].ToString() != "") { doble_bath = Convert.ToDecimal(obj_dcrow["BHT"].ToString()); }
	               dr["Week"] = obj_dcrow["Week"].ToString();
	               dr["DC"] = obj_dcrow["DC_NO"].ToString();
	               dr["Vendor"] = obj_dcrow["Vendor_Code"].ToString();
	               dr["VendorName"] = obj_dcrow["Vendor_Name"].ToString();
	               dr["Load"] = doble_load;
	               dr["Case"] = doble_case;
                   dr["Bath"] = doble_bath;
                   dt.Rows.Add(dr);
               } obj_dcrow.Close();
               
               var x = (from r in dt.AsEnumerable() select r["DC"]).Distinct().ToList();
               if (str_dc != "0")
               {
                   x = (from r in dt.AsEnumerable() where r.Field<string>("DC") == str_dc select r["DC"]).Distinct().ToList();
               }
               string detailColor = "style=\"background-color:#ffffff;\"";
               foreach(string value in x)
               {
                   var vendors = (from m in dt.AsEnumerable()
                                   where m.Field<string>("DC") == value
                                   orderby m["Vendor"] ascending, m["VendorName"] ascending
                                   select new 
                                     {
                                         DC = m.Field<string>("DC"),
                                         Vendor = m.Field<string>("Vendor"),
                                         VendorName = m.Field<string>("VendorName")
                                     }).Distinct().ToList();
                    string strFirst = "";
                    foreach(var vendor in vendors)
                    {
                        
       %>
            <tr <%= detailColor %>>
                <td style="text-align:center;vertical-align:top;" ><% if (strFirst != vendor.DC) { Response.Write(vendor.DC); } %></td>
                <td style="text-align:center;vertical-align:top;" ><%=vendor.Vendor %></td>
                <td style="text-align:left;vertical-align:top;" ><%=vendor.VendorName %></td>
             <% 
                     
                 for(i=Convert.ToInt32(str_wkstart);i<=Convert.ToInt32(str_wkend);i++){
                     
                     DataRow[] result = dt.Select("Week = '" + Convert.ToString(i) + "' AND DC = " + vendor.DC + " AND Vendor = '" + vendor.Vendor + "' AND VendorName = '" + vendor.VendorName + "'");
                     
             %>
                <td style="text-align:right;">
                    <%
                     foreach (DataRow row in result)
                     {
                         string str_load = row["Load"].ToString();
                         if (str_load == "") { str_load = ""; } else { str_load = Convert.ToDouble(str_load.ToString()).ToString("#,##0.00");}
                         Response.Write(str_load);
                     }                  
                    %>
                </td>
                <td style="text-align:right;">
                    <%
                     foreach (DataRow row in result)
                     {
                         string str_case = row["Case"].ToString();
                         if (str_case == "") { str_case = ""; } else { str_case = Convert.ToDouble(str_case.ToString()).ToString("#,##0.00");}
                         Response.Write(str_case);
                     }
                    %>
               </td>
               <td style="text-align:right;">
                    <%
                     foreach (DataRow row in result)
                     {
                         string str_bath = row["Bath"].ToString();
                         if (str_bath == "") { str_bath = ""; } else { str_bath = Convert.ToDouble(str_bath.ToString()).ToString("#,##0.00");}
                         Response.Write(str_bath);
                     } 
                    %>
                </td>
            <% }  %>
        </tr>

        <% strFirst = vendor.DC;} %>
        <tr style="background-color:#9bbb59;">
            <td style="text-align:center;" colspan="3"><%=strFirst %> Total</td>
             <% for(i=Convert.ToInt32(str_wkstart);i<=Convert.ToInt32(str_wkend);i++){ %>
            <td style="text-align:right;">
                <%
                    string subTotailLoad = dt.Compute("Sum(Load)", "Week = '" + Convert.ToString(i) + "' AND DC = " + strFirst + "").ToString();
                    if (subTotailLoad == "") { subTotailLoad = "0"; }
                    Response.Write(Convert.ToDouble(subTotailLoad).ToString("#,##0.00"));
                %>
            </td>
            <td style="text-align:right;">
                <%
                    string subTotailCase = dt.Compute("Sum(Case)", "Week = '" + Convert.ToString(i) + "' AND DC = " + strFirst + "").ToString();
                    if (subTotailCase == "") { subTotailCase = "0"; }
                    Response.Write(Convert.ToDouble(subTotailCase).ToString("#,##0.00"));
                %>
            </td>
            <td style="text-align:right;">
                <%
                    string subTotailBath = dt.Compute("Sum(Bath)", "Week = '" + Convert.ToString(i) + "' AND DC = " + strFirst + "").ToString();
                    if (subTotailBath == "") { subTotailBath = "0"; }
                    Response.Write(Convert.ToDouble(subTotailBath).ToString("#,##0.00"));
                %>
            </td>
        <% } %>
            </tr>

        <% } %>
        <tr style="background-color:#004f0b;">
            <td style="text-align:center;color:#ffffff;" colspan="3">Grand Total</td>
             <% for(i=Convert.ToInt32(str_wkstart);i<=Convert.ToInt32(str_wkend);i++){ %>
            <td style="text-align:right;color:#ffffff;">
                <%
                    string grandTotailLoad = dt.Compute("Sum(Load)", "Week = '" + Convert.ToString(i) + "'").ToString();
                    if (grandTotailLoad == "") { grandTotailLoad = "0"; }
                    Response.Write(Convert.ToDouble(grandTotailLoad).ToString("#,##0.00"));
                %>
            </td>
            <td style="text-align:right;color:#ffffff;">
                <%
                    string grandTotailCase = dt.Compute("Sum(Case)", "Week = '" + Convert.ToString(i) + "'").ToString();
                    if (grandTotailCase == "") { grandTotailCase = "0"; }
                    Response.Write(Convert.ToDouble(grandTotailCase).ToString("#,##0.00"));
                %>
            </td>
            <td style="text-align:right;color:#ffffff;">
                <%
                    string grandTotailBath = dt.Compute("Sum(Bath)", "Week = '" + Convert.ToString(i) + "'").ToString();
                    if (grandTotailBath == "") { grandTotailBath = "0"; }
                    Response.Write(Convert.ToDouble(grandTotailBath).ToString("#,##0.00"));
                %>
            </td>
        <% } %>
        </tr>
        </table>

<% } %>
</body>
</html>
