<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="report_finance.aspx.cs" Inherits="PrimaryHaul.WebUI.report_finance" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
<script>
    function js_tab(varTab) {
        document.getElementById('form_view01').style.display = 'none';
        document.getElementById('form_view02').style.display = 'none';
        document.getElementById(varTab).style.display = '';
    }
    function js_export(yw, hl, vd, dc, type) {
        var objyw = document.getElementById(yw).value;
        var objhl = document.getElementById(hl).value;
        var objvd = document.getElementById(vd).value;
        var objdc = '';
        if (type == 1)
        {
            window.open('./pph_include/perview/report_summary.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd, '_blank');
        }
        if (type == 2) {
            window.open('./pph_include/download/report_summary.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd, '_blank');
        }
        if (type == 3) {
            objdc = document.getElementById(dc).value;
            window.open('./pph_include/perview/report.aspx?&yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd + '&dc=' + objdc, '_blank');
        }
        if (type == 4) {
            objdc = document.getElementById(dc).value;
            window.open('./pph_include/download/report.aspx?&yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd + '&dc=' + objdc, '_blank');
        }
        
    }
</script>
<div id="form_button">
<div class="row">
    <div class="col-md-4">
        <input type="button" value="Profit Report Summary" class="btn btn-default" onclick="js_tab('form_view01');" />
        &nbsp;&nbsp;&nbsp;
        <input type="button" value="Profit Report" class="btn btn-default" onclick="js_tab('form_view02');" /></div>
    <div class="col-md-8"></div>
</div>
<br />
</div>
<div id="form_view01" style="display:none;">
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Tesco Year-Week</label></div>
            <div class="col-md-3">
                <select class="form-control" id="YW_SUM" name="YW_SUM">
                
                <% SqlCommand rs_yw_sum = new SqlCommand(sql_yw, objConn); SqlDataReader obj_yw_sum = rs_yw_sum.ExecuteReader(); while (obj_yw_sum.Read()){ %>
                    <option value="<%= obj_yw_sum["Tesco_Year"].ToString() %><%= obj_yw_sum["Tesco_Week"].ToString() %>"><%= obj_yw_sum["Between_Date"].ToString() %></option>
                <% } obj_yw_sum.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Haulier Name</label></div>
            <div class="col-md-3">
                <select class="form-control" id="HL_SUM" name="HL_SUM">
                    <option value="">เลือกทั้งหมด</option>
                <% SqlCommand rs_hl_sum = new SqlCommand(sql_hl, objConn); SqlDataReader obj_hl_sum = rs_hl_sum.ExecuteReader(); while (obj_hl_sum.Read()){ %>
                    <option value="<%= obj_hl_sum["Haulier_Abbr"].ToString() %>"><%= obj_hl_sum["Haulier_Name_En"].ToString() %></option>
                <% } obj_hl_sum.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Vendor Name</label></div>
            <div class="col-md-3">
                <select class="form-control" id="VD_SUM" name="VD_SUM">
                    <option value="">เลือกทั้งหมด</option>
                <% SqlCommand rs_vd_sum = new SqlCommand(sql_vd, objConn); SqlDataReader obj_vd_sum = rs_vd_sum.ExecuteReader(); while (obj_vd_sum.Read()){ %>
                    <option value="<%= obj_vd_sum["VendorID"].ToString() %>"><%= obj_vd_sum["Vendor_Name_En"].ToString() %></option>
                <% } obj_vd_sum.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2" ><label class="control-label"></label></div>
            <div class="col-md-7" ><input type="button" value="Perview" class="btn btn-default" onclick="js_export('YW_SUM', 'HL_SUM', 'VD_SUM', '', '1');" />&nbsp;&nbsp;&nbsp;<input type="button" value="Export To Excel" class="btn btn-default" onclick="    js_export('YW_SUM', 'HL_SUM', 'VD_SUM', '', '2');" /></div>
        </div>
    </div>
</div>

<div id="form_view02" style="display:none;">
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Tesco Year-Week</label></div>
            <div class="col-md-3">
                <select class="form-control" id="YW" name="YW">
                <% SqlCommand rs_yw = new SqlCommand(sql_yw, objConn); SqlDataReader obj_yw = rs_yw.ExecuteReader(); while (obj_yw.Read()){ %>
                    <option value="<%= obj_yw["Tesco_Year"].ToString() %><%= obj_yw["Tesco_Week"].ToString() %>"><%= obj_yw["Between_Date"].ToString() %></option>
                <% } obj_yw.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Haulier Name</label></div>
            <div class="col-md-3">
                <select class="form-control" id="HL" name="HL">
                    <option value="">เลือกทั้งหมด</option>
                <% SqlCommand rs_hl = new SqlCommand(sql_hl, objConn); SqlDataReader obj_hl = rs_hl.ExecuteReader(); while (obj_hl.Read()){ %>
                    <option value="<%= obj_hl["Haulier_Abbr"].ToString() %>"><%= obj_hl["Haulier_Name_En"].ToString() %></option>
                <% } obj_hl.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Vendor Name</label></div>
            <div class="col-md-3">
                <select class="form-control" id="VD" name="VD">
                    <option value="">เลือกทั้งหมด</option>
                <% SqlCommand rs_vd = new SqlCommand(sql_vd, objConn); SqlDataReader obj_vd = rs_vd.ExecuteReader(); while (obj_vd.Read()){ %>
                    <option value="<%= obj_vd["VendorID"].ToString() %>"><%= obj_vd["Vendor_Name_En"].ToString() %></option>
                <% } obj_vd.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">DC Name</label></div>
            <div class="col-md-3">
                <select class="form-control" id="DC" name="DC">
                    <option value="">เลือกทั้งหมด</option>
                <%  SqlCommand rs_dc = new SqlCommand(sql_dc, objConn); SqlDataReader obj_dc = rs_dc.ExecuteReader(); while (obj_dc.Read()){ %>
                    <option value="<%= obj_dc["dc_abbr"].ToString() %>"><%= obj_dc["DC_Name"].ToString() %></option>
                <% } obj_dc.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2" ><label class="control-label"></label></div>
            <div class="col-md-7" ><input type="button" value="Perview" class="btn btn-default" onclick="js_export('YW', 'HL', 'VD', 'DC', '3');" />&nbsp;&nbsp;&nbsp;<input type="button" value="Export To Excel" class="btn btn-default" onclick="js_export('YW', 'HL', 'VD', 'DC', '4');" /></div>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>
