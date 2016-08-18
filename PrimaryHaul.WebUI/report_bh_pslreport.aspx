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
                window.open('./pph_include/download/report_bh_accounting.aspx?wkstart=' + obj_wkstart + '&wkend=' + obj_wkend + '&dc=' + obj_dc, '_blank');
            }
        }
    }
</script>
<% 
    string str_wkstart = ""; if (!string.IsNullOrEmpty(Request.QueryString["wkstart"] as string)) { str_wkstart = Request.QueryString["wkstart"].ToString(); }
    string str_wkend = ""; if (!string.IsNullOrEmpty(Request.QueryString["wkend"] as string)) { str_wkend = Request.QueryString["wkend"].ToString(); }
    string str_dc = "0"; if (!string.IsNullOrEmpty(Request.QueryString["dc"] as string)) { str_dc = Request.QueryString["dc"].ToString(); }
%>
<div class="form-group">
    <div class="row">
        <div class="col-md-12"><h4>Backhaul PSL Report</h4><hr /></div>
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
<div class="form-group">
    <div class="row">
        <div class="col-md-2"><label class="control-label">DC Name : </label></div>
        <div class="col-md-3">
            <select class="form-control" id="DC" name="DC">
                <option value="0" <% if (str_dc == "0") { Response.Write("selected"); } %>>เลือกทั้งหมด</option>
                <%  SqlCommand rs_dc = new SqlCommand(sql_dc, objConn); SqlDataReader obj_dc = rs_dc.ExecuteReader(); while (obj_dc.Read()){ %>
                    <option value="<%= obj_dc["DC_NO"].ToString() %>" <% if (str_dc == obj_dc["DC_NO"].ToString()) { Response.Write("selected"); } %>><%= obj_dc["DC_NO"].ToString() %> | <%= obj_dc["DC_Name"].ToString() %></option>
                <% } obj_dc.Close(); %>
            </select>
        </div>
    </div>
</div>
<div class="form-group">
    <div class="row">
        <div class="col-md-2" ><label class="control-label"></label></div>
        <div class="col-md-7" ><input type="button" value="Preview" class="btn btn-default" onclick="js_submit('WKStart', 'WKEnd', 'DC', '1', 'urlSubmit');" id="btn01" />&nbsp;&nbsp;&nbsp;<input type="button" value="Export To Excel" class="btn btn-default" onclick="    js_export('WKStart', 'WKEnd', 'DC', '2', 'urlSubmit');" id="btn02" /></div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>
