<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="report_bh_accounting.aspx.cs" Inherits="PrimaryHaul.WebUI.report_bh_accounting" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="System.Linq"%>
<%@ Import Namespace="System.Collections.Generic"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
<input type="hidden" name="urlSubmit" id="urlSubmit" value="<%= HttpContext.Current.Request.Url.AbsolutePath %>?r=<%= Request.QueryString["r"].ToString() %>&id=<%= Request.QueryString["id"].ToString() %>" />
<script>
    function js_submit(wkstart, wkend, dc, vd, excel, mainurl) {
        var obj_wkstart = document.getElementById(wkstart).value;
        var obj_wkend = document.getElementById(wkend).value;
        var obj_dc = document.getElementById(dc).value;
        var obj_vd = document.getElementById(vd).value;
        var obj_mainurl = document.getElementById(mainurl).value;
        if (obj_wkstart == "" || obj_wkend == "") {
            alert('กรุณาเลือก Week');
        } else {
            if (excel == "1") {
                window.location.href = obj_mainurl + '&wkstart=' + obj_wkstart + '&wkend=' + obj_wkend + '&dc=' + obj_dc + '&vd=' + obj_vd;
            } else {
                window.open('./pph_include/download/report_bh_accounting.aspx?wkstart=' + obj_wkstart + '&wkend=' + obj_wkend + '&dc=' + obj_dc + '&vd=' + obj_vd, '_blank');
            }
        }
    }
    function js_viewForm(wkstart, wkend, mainurl) {
        var obj_wkstart = document.getElementById(wkstart).value;
        var obj_wkend = document.getElementById(wkend).value;
        var obj_mainurl = document.getElementById(mainurl).value;
        if (obj_wkstart != "" || obj_wkend != "") {
            window.location.href = obj_mainurl + '&wkstart=' + obj_wkstart + '&wkend=' + obj_wkend;
        }
    }
</script>
<% 
    string str_wkstart = ""; if (!string.IsNullOrEmpty(Request.QueryString["wkstart"] as string)) { str_wkstart = Request.QueryString["wkstart"].ToString(); }
    string str_wkend = ""; if (!string.IsNullOrEmpty(Request.QueryString["wkend"] as string)) { str_wkend = Request.QueryString["wkend"].ToString(); }
    string str_dc = "0"; if (!string.IsNullOrEmpty(Request.QueryString["dc"] as string)) { str_dc = Request.QueryString["dc"].ToString(); }
    string str_vd = "ALL"; if (!string.IsNullOrEmpty(Request.QueryString["vd"] as string)) { str_vd = Request.QueryString["vd"].ToString(); } 
%>
<div class="form-group">
    <div class="row">
        <div class="col-md-12"><h4>Backhaul Accounting</h4><hr /></div>
    </div>
</div>
<div class="form-group">
    <div class="row">
        <div class="col-md-2"><label class="control-label">Week : </label></div>
        <div class="col-md-3">
            <select class="form-control" id="WKStart" name="WKStart">
                <option value="" <% if (str_wkstart == "") { Response.Write("selected"); } %>>กรุณาเลือก</option>
                <% SqlCommand rs_wkstart = new SqlCommand(sql_yw, objConn); SqlDataReader obj_wkstart = rs_wkstart.ExecuteReader(); while (obj_wkstart.Read()){ %>
                    <option value="<%= obj_wkstart["dateweek"].ToString() %>" <% if (str_wkstart == obj_wkstart["dateweek"].ToString()) { Response.Write("selected"); } %>><%= obj_wkstart["dateweek"].ToString() %> | <%= obj_wkstart["Between_Date"].ToString() %></option>
                <% } obj_wkstart.Close(); %>
            </select>
        </div>
        <div class="col-md-1"><label class="control-label">to : </label></div>
        <div class="col-md-3">
            <select class="form-control" id="WKEnd" name="WKEnd">
                <option value="" <% if (str_wkend == "") { Response.Write("selected"); } %>>กรุณาเลือก</option>
                <% SqlCommand rs_wkend = new SqlCommand(sql_yw, objConn); SqlDataReader obj_wkend = rs_wkend.ExecuteReader(); while (obj_wkend.Read()){ %>
                    <option value="<%= obj_wkend["dateweek"].ToString() %>" <% if (str_wkend == obj_wkend["dateweek"].ToString()) { Response.Write("selected"); } %>><%= obj_wkend["dateweek"].ToString() %> | <%= obj_wkend["Between_Date"].ToString() %></option>
                <% } obj_wkend.Close(); %>
            </select>
        </div>
    </div>
</div>
 <% if(str_wkstart != "" && str_wkend != ""){ %>
<div class="form-group">
    <div class="row">
        <div class="col-md-2"><label class="control-label">DC Name : </label></div>
        <div class="col-md-3">
            <select class="form-control" id="DC" name="DC">
                <option value="0" <% if (str_dc == "0") { Response.Write("selected"); } %>>เลือกทั้งหมด</option>
                <%  SqlCommand rs_dc = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_dc.CommandType = CommandType.StoredProcedure;  rs_dc.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_dc.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader obj_dc = rs_dc.ExecuteReader(); while (obj_dc.Read()){ %>
                    <option value="<%= obj_dc["DC_NO"].ToString() %>" <% if (str_dc == obj_dc["DC_NO"].ToString()) { Response.Write("selected"); } %>><%= obj_dc["DC_NO"].ToString() %></option>
                <% } obj_dc.Close(); %>
            </select>
        </div>
    </div>
</div>
<div class="form-group">
    <div class="row">
        <div class="col-md-2"><label class="control-label">Vendor Name : </label></div>
        <div class="col-md-3">
            <select class="form-control" id="VD" name="VD">
                <option value="ALL" <% if (str_vd == "ALL") { Response.Write("selected"); } %>>เลือกทั้งหมด</option>
                <% SqlCommand rs_vd = new SqlCommand("usp_BH_GET_VendorName_ON_WEEK", objConn); rs_vd.CommandType = CommandType.StoredProcedure;  rs_vd.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_vd.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader obj_vd = rs_vd.ExecuteReader(); while (obj_vd.Read()){ %>
                    <option value="<%= obj_vd["Vendor_Name"].ToString() %>" <% if (str_vd == obj_vd["Vendor_Name"].ToString()) { Response.Write("selected"); } %>><%= obj_vd["Vendor_Name"].ToString() %></option>
                <% } obj_vd.Close(); %>
            </select>
        </div>
    </div>
</div>
<div class="form-group">
    <div class="row">
        <div class="col-md-2" ><label class="control-label"></label></div>
        <div class="col-md-7" ><input type="button" value="Preview" class="btn btn-default" onclick="js_submit('WKStart', 'WKEnd', 'DC', 'VD', '1', 'urlSubmit');" id="btn01" />&nbsp;&nbsp;&nbsp;<input type="button" value="Export To Excel" class="btn btn-default" onclick="    js_submit('WKStart', 'WKEnd', 'DC', 'VD', '2', 'urlSubmit');" id="btn02" /></div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">&nbsp;</div>
</div> 
 <% if(Convert.ToInt32(str_wkstart) <= Convert.ToInt32(str_wkend)){ int i;%>
<div class="row">
    <div class="col-md-12">
        <table class="table table-bordered">
        <tr style="background-color:#9bbb59;">
            <td style="text-align:center;" colspan="3">&nbsp;</td>
            <% for(i=Convert.ToInt32(str_wkstart);i<=Convert.ToInt32(str_wkend);i++){ %>
                <td style="text-align:center;" colspan="4">WK<%=Convert.ToString(i).Substring(Convert.ToString(i).Length - 2,2)%></td>
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
                <td style="text-align:center;">Income Type</td>
            <% } %>
        </tr>
        <%                
               DataTable dt = new DataTable();
               DataRow dr;
               dt.Columns.Add("Week");
               dt.Columns.Add("DC");
               dt.Columns.Add("Vendor");
               dt.Columns.Add("VendorName");
               dt.Columns.Add("IncomeType");
               dt.Columns.Add("Load", typeof(Double));
               dt.Columns.Add("Case", typeof(Double));
               dt.Columns.Add("Bath", typeof(Double));
               SqlCommand rs_dcrow = new SqlCommand("usp_BH_RPT_Accounting", objConn); rs_dcrow.CommandType = CommandType.StoredProcedure; rs_dcrow.Parameters.AddWithValue("@Week_Start", str_wkstart); rs_dcrow.Parameters.AddWithValue("@Week_End", str_wkend); rs_dcrow.Parameters.AddWithValue("@DC_No", str_dc); ; rs_dcrow.Parameters.AddWithValue("@Vendor_Name", str_vd); SqlDataReader obj_dcrow = rs_dcrow.ExecuteReader(); while (obj_dcrow.Read())
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
                   dr["IncomeType"] = obj_dcrow["IncomeType"].ToString();
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
                <td style="text-align:center;">
                    <%
                     foreach (DataRow row in result)
                     {
                         string str_bath = row["IncomeType"].ToString();
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
            <td style="text-align:right;"></td>
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
            <td style="text-align:right;"></td>
        <% } %>
        </tr>
        </table>
    </div>
</div>
<% } %>
<% }else{ %>
<div class="form-group">
    <div class="row">
        <div class="col-md-2" ><label class="control-label"></label></div>
        <div class="col-md-7" ><input type="button" value="ทำรายการ" class="btn btn-default" onclick="js_viewForm('WKStart', 'WKEnd', 'urlSubmit');" id="btn03" /></div>
    </div>
</div>
<% } %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>
