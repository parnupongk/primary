<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="report_bh_pslreport.aspx.cs" Inherits="PrimaryHaul.WebUI.report_bh_pslreport" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Import Namespace="PrimaryHaul_WSFlow"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
<input type="hidden" name="urlSubmit" id="urlSubmit" value="<%= HttpContext.Current.Request.Url.AbsolutePath %>?r=<%= Request.QueryString["r"].ToString() %>&id=<%= Request.QueryString["id"].ToString() %>" />
<script>
    function js_submit(wkstart, wkend, dc, excel, mainurl) {
        var obj_wkstart = document.getElementById(wkstart).value;
        var obj_wkend = document.getElementById(wkend).value;
        var obj_dc = document.getElementById(dc).value;
        var obj_mainurl = document.getElementById(mainurl).value;
        if (obj_wkstart == "" || obj_wkend == "") {
            alert('กรุณาเลือก Week');
        } else {
            if (excel == "1") {
                window.location.href = obj_mainurl + '&wkstart=' + obj_wkstart + '&wkend=' + obj_wkend + '&dc=' + obj_dc;
            } else {
                window.open('./pph_include/download/report_bh_pslreport.aspx?wkstart=' + obj_wkstart + '&wkend=' + obj_wkend + '&dc=' + obj_dc, '_blank');
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
    string str_dc = "99999"; if (!string.IsNullOrEmpty(Request.QueryString["dc"] as string)) { str_dc = Request.QueryString["dc"].ToString(); }
%>

<div class="form-group">
    <div class="row">
        <div class="col-md-12"><h4>Backhaul P&L Report</h4><hr /></div>
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
                <option value="99999" <% if (str_dc == "99999") { Response.Write("selected"); } %>>เลือกทั้งหมด</option>
                <%  SqlCommand rs_dc = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_dc.CommandType = CommandType.StoredProcedure;  rs_dc.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_dc.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader obj_dc = rs_dc.ExecuteReader(); while (obj_dc.Read()){ %>
                    <option value="<%= obj_dc["DC_NO"].ToString() %>" <% if (str_dc == obj_dc["DC_NO"].ToString()) { Response.Write("selected"); } %>><%= obj_dc["DC_NO"].ToString() %></option>
                <% } obj_dc.Close(); %>
            </select>
        </div>
    </div>
</div>
<div class="form-group">
    <div class="row">
        <div class="col-md-2" ><label class="control-label"></label></div>
        <div class="col-md-7" ><input type="button" value="Preview" class="btn btn-default" onclick="js_submit('WKStart', 'WKEnd', 'DC', '1', 'urlSubmit');" id="btn01" />&nbsp;&nbsp;&nbsp;<input type="button" value="Export To Excel" class="btn btn-default" onclick="    js_submit('WKStart', 'WKEnd', 'DC', '2', 'urlSubmit');" id="btn02" /></div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">&nbsp;</div>
</div> 
<% if(Convert.ToInt32(str_wkstart) <= Convert.ToInt32(str_wkend)){ int i;%>
<div class="row">
    <div class="col-md-12">
        <table class="table table-bordered">
        <tr style="background-color:#ffffff;">
            <td style="text-align:left;font-weight:bold;width:200px;">Income</td> 
            <%  SqlCommand rs_count1 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_count1.CommandType = CommandType.StoredProcedure; rs_count1.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_count1.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader countCol1 = rs_count1.ExecuteReader(); int iCol1 = 0; while (countCol1.Read()) { iCol1++; } countCol1.Close(); %>
            <td style="text-align:center;" colspan="<%=iCol1 %>"></td> 
        </tr>
        <tr style="background-color:#9bbb59;">
            <td style="text-align:center;">DC NO</td> 
            <%  SqlCommand rs_col_dc1 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_col_dc1.CommandType = CommandType.StoredProcedure;  rs_col_dc1.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_col_dc1.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader col_dc1 = rs_col_dc1.ExecuteReader(); while (col_dc1.Read()){ %>
                 <td style="text-align:center;"><%=col_dc1["DC_NO"].ToString() %></td> 
            <% } col_dc1.Close(); %>
        </tr>
        <% for(i=Convert.ToInt32(str_wkstart);i<=Convert.ToInt32(str_wkend);i++){ %>
        <tr style="background-color:#fff;">
            <td style="text-align:center;">WK<%=Convert.ToString(i).Substring(Convert.ToString(i).Length - 2,2)%></td>
            <%  SqlCommand rs_col_dcDetail1 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_col_dcDetail1.CommandType = CommandType.StoredProcedure;  rs_col_dcDetail1.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_col_dcDetail1.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader col_dcDetail1 = rs_col_dcDetail1.ExecuteReader(); while (col_dcDetail1.Read()){ %>
                 <td style="text-align:right;width:200px;">
                 <% 
                    SqlCommand rs_detail1 = new SqlCommand("usp_BH_PSL_Report", objConn);
                    rs_detail1.CommandType = CommandType.StoredProcedure;
                    rs_detail1.Parameters.AddWithValue("@Week_Start", "" + i + "");
                    rs_detail1.Parameters.AddWithValue("@Week_End", "" + i + "");
                    rs_detail1.Parameters.AddWithValue("@DC_No", "" + Convert.ToInt32(col_dcDetail1["DC_NO"].ToString()) + "");
                    rs_detail1.Parameters.AddWithValue("@Data", "Income");
                    SqlDataReader obj_detail1 = rs_detail1.ExecuteReader();
                    if (obj_detail1.HasRows)
                    {
                        obj_detail1.Read();
                        Response.Write(Convert.ToDouble(obj_detail1["BHT"].ToString()).ToString("#,##0.00"));
                        obj_detail1.Close();
                    }
                 %>
                 </td>
            <% } col_dcDetail1.Close(); %>
        </tr>
        <% } %>
        </table>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <table class="table table-bordered">
        <tr style="background-color:#ffffff;">
            <td style="text-align:left;font-weight:bold;width:200px;">Unloading</td> 
            <%  SqlCommand rs_count2 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_count2.CommandType = CommandType.StoredProcedure; rs_count2.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_count2.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader countCol2 = rs_count1.ExecuteReader(); int iCol2= 0; while (countCol2.Read()) { iCol2++; } countCol2.Close(); %>
            <td style="text-align:center;" colspan="<%=iCol2 %>"></td> 
        </tr>
        <tr style="background-color:#9bbb59;">
            <td style="text-align:center;">DC NO</td> 
            <%  SqlCommand rs_col_dc2 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_col_dc2.CommandType = CommandType.StoredProcedure;  rs_col_dc2.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_col_dc2.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader col_dc2 = rs_col_dc2.ExecuteReader(); while (col_dc2.Read()){ %>
                 <td style="text-align:center;"><%=col_dc2["DC_NO"].ToString() %></td> 
            <% } col_dc2.Close(); %>
        </tr>
        <% for(i=Convert.ToInt32(str_wkstart);i<=Convert.ToInt32(str_wkend);i++){ %>
        <tr style="background-color:#fff;">
            <td style="text-align:center;">WK<%=Convert.ToString(i).Substring(Convert.ToString(i).Length - 2,2)%></td>
            <%  SqlCommand rs_col_dcDetail2 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_col_dcDetail2.CommandType = CommandType.StoredProcedure;  rs_col_dcDetail2.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_col_dcDetail2.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader col_dcDetail2 = rs_col_dcDetail2.ExecuteReader(); while (col_dcDetail2.Read()){ %>
                 <td style="text-align:right;width:200px;">
                 <% 
                    SqlCommand rs_detail2 = new SqlCommand("usp_BH_PSL_Report", objConn);
                    rs_detail2.CommandType = CommandType.StoredProcedure;
                    rs_detail2.Parameters.AddWithValue("@Week_Start", "" + i + "");
                    rs_detail2.Parameters.AddWithValue("@Week_End", "" + i + "");
                    rs_detail2.Parameters.AddWithValue("@DC_No", "" + Convert.ToInt32(col_dcDetail2["DC_NO"].ToString()) + "");
                    rs_detail2.Parameters.AddWithValue("@Data", "Unloading");
                    SqlDataReader obj_detail2 = rs_detail2.ExecuteReader();
                    if (obj_detail2.HasRows)
                    {
                        obj_detail2.Read();
                        Response.Write(Convert.ToDouble(obj_detail2["BHT"].ToString()).ToString("#,##0.00"));
                        obj_detail2.Close();
                    }
                 %>
                 </td>
            <% } col_dcDetail2.Close(); %>
        </tr>
        <% } %>
        </table>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <table class="table table-bordered">
        <tr style="background-color:#ffffff;">
            <td style="text-align:left;font-weight:bold;width:200px;">Case</td> 
            <%  SqlCommand rs_count3 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_count3.CommandType = CommandType.StoredProcedure; rs_count3.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_count3.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader countCol3 = rs_count1.ExecuteReader(); int iCol3= 0; while (countCol3.Read()) { iCol3++; } countCol3.Close(); %>
            <td style="text-align:center;" colspan="<%=iCol3 %>"></td> 
        </tr>
        <tr style="background-color:#9bbb59;">
            <td style="text-align:center;">DC NO</td> 
            <%  SqlCommand rs_col_dc3 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_col_dc3.CommandType = CommandType.StoredProcedure;  rs_col_dc3.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_col_dc3.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader col_dc3 = rs_col_dc3.ExecuteReader(); while (col_dc3.Read()){ %>
                 <td style="text-align:center;"><%=col_dc3["DC_NO"].ToString() %></td> 
            <% } col_dc3.Close(); %>
        </tr>
        <% for(i=Convert.ToInt32(str_wkstart);i<=Convert.ToInt32(str_wkend);i++){ %>
        <tr style="background-color:#fff;">
            <td style="text-align:center;">WK<%=Convert.ToString(i).Substring(Convert.ToString(i).Length - 2,2)%></td>
            <%  SqlCommand rs_col_dcDetail3 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_col_dcDetail3.CommandType = CommandType.StoredProcedure;  rs_col_dcDetail3.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_col_dcDetail3.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader col_dcDetail3 = rs_col_dcDetail3.ExecuteReader(); while (col_dcDetail3.Read()){ %>
                 <td style="text-align:right;width:200px;">
                 <% 
                    SqlCommand rs_detail3 = new SqlCommand("usp_BH_PSL_Report", objConn);
                    rs_detail3.CommandType = CommandType.StoredProcedure;
                    rs_detail3.Parameters.AddWithValue("@Week_Start", "" + i + "");
                    rs_detail3.Parameters.AddWithValue("@Week_End", "" + i + "");
                    rs_detail3.Parameters.AddWithValue("@DC_No", "" + Convert.ToInt32(col_dcDetail3["DC_NO"].ToString()) + "");
                    rs_detail3.Parameters.AddWithValue("@Data", "Case");
                    SqlDataReader obj_detail3 = rs_detail3.ExecuteReader();
                    if (obj_detail3.HasRows)
                    {
                        obj_detail3.Read();
                        Response.Write(Convert.ToDouble(obj_detail3["BHT"].ToString()).ToString("#,##0.00"));
                        obj_detail3.Close();
                    }
                 %>
                 </td>
            <% } col_dcDetail3.Close(); %>
        </tr>
        <% } %>
        </table>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <table class="table table-bordered">
        <tr style="background-color:#ffffff;">
            <td style="text-align:left;font-weight:bold;width:200px;">Load</td> 
            <%  SqlCommand rs_count4 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_count4.CommandType = CommandType.StoredProcedure; rs_count4.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_count4.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader countCol4 = rs_count1.ExecuteReader(); int iCol4= 0; while (countCol4.Read()) { iCol4++; } countCol4.Close(); %>
            <td style="text-align:center;" colspan="<%=iCol4 %>"></td> 
        </tr>
        <tr style="background-color:#9bbb59;">
            <td style="text-align:center;">DC NO</td> 
            <%  SqlCommand rs_col_dc4 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_col_dc4.CommandType = CommandType.StoredProcedure;  rs_col_dc4.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_col_dc4.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader col_dc4 = rs_col_dc4.ExecuteReader(); while (col_dc4.Read()){ %>
                 <td style="text-align:center;"><%=col_dc4["DC_NO"].ToString() %></td> 
            <% } col_dc4.Close(); %>
        </tr>
        <% for(i=Convert.ToInt32(str_wkstart);i<=Convert.ToInt32(str_wkend);i++){ %>
        <tr style="background-color:#fff;">
            <td style="text-align:center;">WK<%=Convert.ToString(i).Substring(Convert.ToString(i).Length - 2,2)%></td>
            <%  SqlCommand rs_col_dcDetail4 = new SqlCommand("usp_BH_GET_DC_ON_WEEK", objConn); rs_col_dcDetail4.CommandType = CommandType.StoredProcedure;  rs_col_dcDetail4.Parameters.AddWithValue("@Week_Start", "" + str_wkstart + ""); rs_col_dcDetail4.Parameters.AddWithValue("@Week_End", "" + str_wkend + ""); SqlDataReader col_dcDetail4 = rs_col_dcDetail4.ExecuteReader(); while (col_dcDetail4.Read()){ %>
                 <td style="text-align:right;width:200px;">
                 <% 
                    SqlCommand rs_detail4 = new SqlCommand("usp_BH_PSL_Report", objConn);
                    rs_detail4.CommandType = CommandType.StoredProcedure;
                    rs_detail4.Parameters.AddWithValue("@Week_Start", "" + i + "");
                    rs_detail4.Parameters.AddWithValue("@Week_End", "" + i + "");
                    rs_detail4.Parameters.AddWithValue("@DC_No", "" + Convert.ToInt32(col_dcDetail4["DC_NO"].ToString()) + "");
                    rs_detail4.Parameters.AddWithValue("@Data", "Load");
                    SqlDataReader obj_detail4 = rs_detail4.ExecuteReader();
                    if (obj_detail4.HasRows)
                    {
                        obj_detail4.Read();
                        Response.Write(Convert.ToDouble(obj_detail4["BHT"].ToString()).ToString("#,##0.00"));
                        obj_detail4.Close();
                    }
                 %>
                 </td> 
            <% } col_dcDetail4.Close(); %>
        </tr>
        <% } %>
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
