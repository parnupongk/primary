<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="report_finance.aspx.cs" Inherits="PrimaryHaul.WebUI.report_finance" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Import Namespace="PrimaryHaul_WSFlow"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
<script>
    function js_tab(varTab) {
        document.getElementById('form_view01').style.display = 'none';
        document.getElementById('form_view02').style.display = 'none';
        document.getElementById('form_view03').style.display = 'none';
        document.getElementById('form_view04').style.display = 'none';
        document.getElementById('form_view05').style.display = 'none';
        document.getElementById('form_view06').style.display = 'none';
        document.getElementById(varTab).style.display = '';
    }
    function js_export(yw, hl, vd, dc, type, reportSum) {
        var objyw = '';
        var objhl = '';
        var objvd = '';
        var objdc = '';
        var objrSum = '';
        objyw = document.getElementById(yw).value;
        if (objyw == "") {
            document.getElementById('bt01').disabled = true;
            document.getElementById('bt02').disabled = true;
            document.getElementById('bt03').disabled = true;
            document.getElementById('bt04').disabled = true;
            alert('กรุณาเลือก Tesco Year-Week');
            return false;
        }
        else
        {
            document.getElementById('bt01').disabled = false;
            document.getElementById('bt02').disabled = false;
            document.getElementById('bt03').disabled = false;
            document.getElementById('bt04').disabled = false;
        }
        if (type == 1)
        {
            objhl = document.getElementById(hl).value;
            objvd = document.getElementById(vd).value;
            if (document.getElementById(reportSum).checked) {
                window.open('./pph_include/perview/report_summary_sum.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd, '_blank');
            } else {
                window.open('./pph_include/perview/report_summary.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd, '_blank');
            }
        }
        if (type == 2) {
            objhl = document.getElementById(hl).value;
            objvd = document.getElementById(vd).value;
            if (document.getElementById(reportSum).checked) {
                window.open('./pph_include/download/report_summary_sum.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd, '_blank');
            } else {
                window.open('./pph_include/download/report_summary.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd, '_blank');
            }
        }
        if (type == 3) {
            objhl = document.getElementById(hl).value;
            objvd = document.getElementById(vd).value;
            objdc = document.getElementById(dc).value;
            if (document.getElementById(reportSum).checked) {
                window.open('./pph_include/perview/report_sum.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd + '&dc=' + objdc, '_blank');
            } else {
                window.open('./pph_include/perview/report.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd + '&dc=' + objdc, '_blank');
            }
        }
        if (type == 4) {
            objhl = document.getElementById(hl).value;
            objvd = document.getElementById(vd).value;
            objdc = document.getElementById(dc).value;
            if (document.getElementById(reportSum).checked) {
                window.open('./pph_include/download/report_sum.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd + '&dc=' + objdc, '_blank');
            } else {
                window.open('./pph_include/download/report.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd + '&dc=' + objdc, '_blank');
            }
        }
        if (type == 5) {
            window.open('./pph_include/perview/hualier_cost.aspx?yw=' + objyw, '_blank');
        }
        if (type == 6) {
            window.open('./pph_include/download/hualier_cost.aspx?yw=' + objyw, '_blank');
        }
        if (type == 7) {
            objhl = document.getElementById(hl).value;
            objvd = document.getElementById(vd).value;
            objdc = document.getElementById(dc).value;
            if (objvd == '') { alert('กรุณาเลือก Vendor Name'); return false; } else { } window.location.href='./report_finance.aspx?yw=' + objyw + '&r=' + objhl + '&vd=' + objvd + '&id=' + objdc +'';
        }
        if (type == 8) {
            window.open('./pph_include/perview/vendor_download_log.aspx?yw=' + objyw, '_blank');
        }
        if (type == 9) {
            window.open('./pph_include/download/vendor_download_log.aspx?yw=' + objyw, '_blank');
        }
        if (type == 10) {
            objhl = document.getElementById(hl).value;
            if (objhl == "")
            {
                alert('กรุณาเลือก Haulier Name');
                return false;
            }
            else
            {
                window.open('./pph_include/download/primary_transaction.aspx?yw=' + objyw + '&hl=' + objhl, '_blank');
            }
            
        }
    }
    function js_export2(yw, hl, vd, dc, type, reportSum, ymEnd) {
        var objyw = '';
        var objhl = '';
        var objvd = '';
        var objdc = '';
        var objrSum = '';
        var objywEnd = '';
        objyw = document.getElementById(yw).value;
        objywEnd = document.getElementById(ymEnd).value;
        if (objyw == "") {
            document.getElementById('bt01').disabled = true;
            document.getElementById('bt02').disabled = true;
            document.getElementById('bt03').disabled = true;
            document.getElementById('bt04').disabled = true;
            alert('กรุณาเลือก Tesco Year-Week start');
            return false;
        }
        else if (objywEnd == "") {
            document.getElementById('bt01').disabled = true;
            document.getElementById('bt02').disabled = true;
            document.getElementById('bt03').disabled = true;
            document.getElementById('bt04').disabled = true;
            alert('กรุณาเลือก Tesco Year-Week end');
            return false;
        }
        else {
            document.getElementById('bt01').disabled = false;
            document.getElementById('bt02').disabled = false;
            document.getElementById('bt03').disabled = false;
            document.getElementById('bt04').disabled = false;
        }
        if (type == 1) {
            objhl = document.getElementById(hl).value;
            objvd = document.getElementById(vd).value;
            if (document.getElementById(reportSum).checked) {
                window.open('./pph_include/perview/report_summary_sum.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd + '&ywend=' + objywEnd, '_blank');
            } else {
                window.open('./pph_include/perview/report_summary.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd + '&ywend=' + objywEnd, '_blank');
            }
        }
        if (type == 2) {
            objhl = document.getElementById(hl).value;
            objvd = document.getElementById(vd).value;
            if (document.getElementById(reportSum).checked) {
                window.open('./pph_include/download/report_summary_sum.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd + '&ywend=' + objywEnd, '_blank');
            } else {
                window.open('./pph_include/download/report_summary.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd + '&ywend=' + objywEnd, '_blank');
            }
        }
        if (type == 3) {
            objhl = document.getElementById(hl).value;
            objvd = document.getElementById(vd).value;
            objdc = document.getElementById(dc).value;
            if (document.getElementById(reportSum).checked) {
                window.open('./pph_include/perview/report_sum.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd + '&dc=' + objdc, '_blank');
            } else {
                window.open('./pph_include/perview/report.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd + '&dc=' + objdc, '_blank');
            }
        }
        if (type == 4) {
            objhl = document.getElementById(hl).value;
            objvd = document.getElementById(vd).value;
            objdc = document.getElementById(dc).value;
            if (document.getElementById(reportSum).checked) {
                window.open('./pph_include/download/report_sum.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd + '&dc=' + objdc, '_blank');
            } else {
                window.open('./pph_include/download/report.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd + '&dc=' + objdc, '_blank');
            }
        }
        if (type == 5) {
            window.open('./pph_include/perview/hualier_cost.aspx?yw=' + objyw + '&ywend=' + objywEnd, '_blank');
        }
        if (type == 6) {
            window.open('./pph_include/download/hualier_cost.aspx?yw=' + objyw + '&ywend=' + objywEnd, '_blank');
        }
        if (type == 7) {
            objhl = document.getElementById(hl).value;
            objvd = document.getElementById(vd).value;
            objdc = document.getElementById(dc).value;
            if (objvd == '') { alert('กรุณาเลือก Vendor Name'); return false; } else { } window.location.href = './report_finance.aspx?yw=' + objyw + '&r=' + objhl + '&vd=' + objvd + '&id=' + objdc + '';
        }
        if (type == 8) {
            window.open('./pph_include/perview/vendor_download_log.aspx?yw=' + objyw, '_blank');
        }
        if (type == 9) {
            window.open('./pph_include/download/vendor_download_log.aspx?yw=' + objyw, '_blank');
        }
        if (type == 10) {
            objhl = document.getElementById(hl).value;
            if (objhl == "") {
                alert('กรุณาเลือก Haulier Name');
                return false;
            }
            else {
                window.open('./pph_include/download/primary_transaction.aspx?yw=' + objyw + '&hl=' + objhl, '_blank');
            }

        }
    }
    function js_revn(var01, var02, var03, var04, var05)
    {
        var objyw = document.getElementById(var01).value;
        if (objyw == "") {
            document.getElementById('bt01').disabled = true;
            document.getElementById('bt02').disabled = true;
            document.getElementById('bt03').disabled = true;
            document.getElementById('bt04').disabled = true;
            document.getElementById('bt05').disabled = true;
            alert('กรุณาเลือก Tesco Year-Week');
            return false;
        }
        else
        {
            document.getElementById('bt01').disabled = false;
            document.getElementById('bt02').disabled = false;
            document.getElementById('bt03').disabled = false;
            document.getElementById('bt04').disabled = false;
            document.getElementById('bt05').disabled = false;
            if (var02 == 'a5') {
                get_vd_report2(objyw, var02, var04);
            } else {
                get_hl_report(objyw, var02, var04);
                get_vd_report(objyw, var03, var05);
            }         
        }
    }
    function js_revn2(var01, var02, var03, var04, var05, var06) {
        var objyw = document.getElementById(var01).value;
        var objywEnd = document.getElementById(var06).value;
        if (objyw == "") {
            document.getElementById('bt01').disabled = true;
            document.getElementById('bt02').disabled = true;
            document.getElementById('bt03').disabled = true;
            document.getElementById('bt04').disabled = true;
            document.getElementById('bt05').disabled = true;
            alert('กรุณาเลือก Tesco Year-Week Start');
            return false;
        }
        else if (objywEnd == "") {
            document.getElementById('bt01').disabled = true;
            document.getElementById('bt02').disabled = true;
            document.getElementById('bt03').disabled = true;
            document.getElementById('bt04').disabled = true;
            document.getElementById('bt05').disabled = true;
            alert('กรุณาเลือก Tesco Year-Week End');
            return false;
        }
        else {
            document.getElementById('bt01').disabled = false;
            document.getElementById('bt02').disabled = false;
            document.getElementById('bt03').disabled = false;
            document.getElementById('bt04').disabled = false;
            document.getElementById('bt05').disabled = false;
            if (var02 == 'a5') {
                get_vd_report2(objyw, var02, var04);
            } else {
                get_hl_report(objyw, var02, var04);
                get_vd_report(objyw, var03, var05);
            }
        }
    }
    function get_hl_report(var01, var02, var03) {
        var req = Inint_AJAX();
        var str = Math.random();
        var str_url_address = "./pph_include/ajax/files/get_hl_report.aspx";
        var str_url = "var01=" + var01;
        str_url += "&var03=" + var03;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    var strRes = req.responseText;
                    document.getElementById(var02).innerHTML = strRes;
                }
            }
        }
        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.send(str_url);
    }
    function get_vd_report(var01, var02, var03) {
        var req = Inint_AJAX();
        var str = Math.random();
        var str_url_address = "./pph_include/ajax/files/get_vd_report.aspx";
        var str_url = "var01=" + var01;
        str_url += "&var03=" + var03;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    var strRes = req.responseText;
                    document.getElementById(var02).innerHTML = strRes;
                }
            }
        }
        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.send(str_url);
    }
    function get_vd_report2(var01, var02, var03) {
        var req = Inint_AJAX();
        var str = Math.random();
        var str_url_address = "./pph_include/ajax/files/get_vd_report2.aspx";
        var str_url = "var01=" + var01;
        str_url += "&var03=" + var03;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    var strRes = req.responseText;
                    document.getElementById(var02).innerHTML = strRes;
                }
            }
        }
        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.send(str_url);
    }
</script>

<div id="form_button">
<div class="row">
    <div class="col-md-12">
        <input type="button" value="Revenue Profit" class="btn btn-default" onclick="js_tab('form_view01');" />
        &nbsp;&nbsp;&nbsp;
        <input type="button" value="Vendor Cost" class="btn btn-default" onclick="js_tab('form_view02');" />
        &nbsp;&nbsp;&nbsp;
        <input type="button" value="Hualier Cost" class="btn btn-default" onclick="js_tab('form_view03');" />
        &nbsp;&nbsp;&nbsp;
        <input type="button" value="Vendor Download Preview" class="btn btn-default" onclick="js_tab('form_view04');" />
        &nbsp;&nbsp;&nbsp;
        <input type="button" value="Vendor Download Log" class="btn btn-default" onclick="js_tab('form_view05');" />
        &nbsp;&nbsp;&nbsp;
        <input type="button" value="Export File Primary Transaction" class="btn btn-default" onclick="js_tab('form_view06');" />
    </div>
    <div class="col-md-8"></div>
</div>
<br />
</div>
<div id="form_view01" style="display:none;">
    <div class="form-group">
        <div class="row">
            <div class="col-md-12">
            <h4>Tesco Finance Report > Revenue Profit</h4><hr />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Tesco Year-Week Start</label></div>
            <div class="col-md-3">
                <select class="form-control" id="YW_SUM" name="YW_SUM">
                 <option value="" selected="selected">กรุณาเลือก</option>
                <% SqlCommand rs_yw_sum = new SqlCommand(sql_yw, objConn); SqlDataReader obj_yw_sum = rs_yw_sum.ExecuteReader(); while (obj_yw_sum.Read()){ %>
                    <option value="<%= obj_yw_sum["Tesco_Year"].ToString() %><%= obj_yw_sum["Tesco_Week"].ToString() %>"><%= obj_yw_sum["Tesco_Year"].ToString() %><%= obj_yw_sum["Tesco_Week"].ToString() %> | <%= obj_yw_sum["Between_Date"].ToString() %></option>
                <% } obj_yw_sum.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Tesco Year-Week End</label></div>
            <div class="col-md-3">
                <select class="form-control" id="YW_SUMEND" name="YW_SUMEND" onchange="js_revn2('YW_SUM', 'a1', 'a2', 'HL_SUM', 'VD_SUM', 'YW_SUMEND');">
                 <option value="" selected="selected">กรุณาเลือก</option>
                <% SqlCommand rs_yw_sumend = new SqlCommand(sql_yw, objConn); SqlDataReader obj_yw_sumend = rs_yw_sumend.ExecuteReader(); while (obj_yw_sumend.Read()){ %>
                    <option value="<%= obj_yw_sumend["Tesco_Year"].ToString() %><%= obj_yw_sumend["Tesco_Week"].ToString() %>"><%= obj_yw_sumend["Tesco_Year"].ToString() %><%= obj_yw_sumend["Tesco_Week"].ToString() %> | <%= obj_yw_sumend["Between_Date"].ToString() %></option>
                <% } obj_yw_sumend.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Haulier Name</label></div>
            <div class="col-md-3">
                <div id="a1">
                <select class="form-control" id="HL_SUM" name="HL_SUM" disabled="disabled">
                    <option value="" selected="selected">เลือกทั้งหมด</option>
                <% SqlCommand rs_hl_sum = new SqlCommand(sql_hl, objConn); SqlDataReader obj_hl_sum = rs_hl_sum.ExecuteReader(); while (obj_hl_sum.Read()){ %>
                    <option value="<%= obj_hl_sum["Haulier_Abbr"].ToString() %>"><%= obj_hl_sum["Haulier_Name_En"].ToString() %></option>
                <% } obj_hl_sum.Close(); %>
                </select>
                </div>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Vendor Name</label></div>
            <div class="col-md-3">
                <div id="a2">
                <select class="form-control" id="VD_SUM" name="VD_SUM"  disabled="disabled">
                    <option value="" selected="selected">เลือกทั้งหมด</option>
                <% SqlCommand rs_vd_sum = new SqlCommand(sql_vd, objConn); SqlDataReader obj_vd_sum = rs_vd_sum.ExecuteReader(); while (obj_vd_sum.Read()){ %>
                    <option value="<%= obj_vd_sum["VendorID"].ToString() %>"><%= obj_vd_sum["Vendor_Name_En"].ToString() %></option>
                <% } obj_vd_sum.Close(); %>
                </select>
                </div>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Summary Report</label></div>
            <div class="col-md-3">
                <input type="checkbox" id="getReportType01" name="getReportType01" value="1" />
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2" ><label class="control-label"></label></div>
            <div class="col-md-7" ><input type="button" value="Preview" class="btn btn-default" onclick="js_export2('YW_SUM', 'HL_SUM', 'VD_SUM', '', '1', 'getReportType01', 'YW_SUMEND');" id="bt01" />&nbsp;&nbsp;&nbsp;<input type="button" value="Export To Excel" class="btn btn-default" onclick="js_export2('YW_SUM', 'HL_SUM', 'VD_SUM', '', '2', 'getReportType01', 'YW_SUMEND');" id="bt02" /></div>
        </div>
    </div>
</div>

<div id="form_view02" style="display:none;">
    <div class="form-group">
        <div class="row">
            <div class="col-md-12">
            <h4>Tesco Finance Report > Vendor Cost</h4><hr />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Tesco Year-Week</label></div>
            <div class="col-md-3">
                <select class="form-control" id="YW" name="YW" onchange="js_revn('YW', 'a3', 'a4', 'HL', 'VD');">
                    <option value="" selected="selected">กรุณาเลือก</option>
                <% SqlCommand rs_yw = new SqlCommand(sql_yw, objConn); SqlDataReader obj_yw = rs_yw.ExecuteReader(); while (obj_yw.Read()){ %>
                    <option value="<%= obj_yw["Tesco_Year"].ToString() %><%= obj_yw["Tesco_Week"].ToString() %>"><%= obj_yw["Tesco_Year"].ToString() %><%= obj_yw["Tesco_Week"].ToString() %> | <%= obj_yw["Between_Date"].ToString() %></option>
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
                <div id="a3">
                <select class="form-control" id="HL" name="HL" disabled="disabled">
                    <option value="">เลือกทั้งหมด</option>
                <% SqlCommand rs_hl = new SqlCommand(sql_hl, objConn); SqlDataReader obj_hl = rs_hl.ExecuteReader(); while (obj_hl.Read()){ %>
                    <option value="<%= obj_hl["Haulier_Abbr"].ToString() %>"><%= obj_hl["Haulier_Name_En"].ToString() %></option>
                <% } obj_hl.Close(); %>
                </select>
                </div>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Vendor Name</label></div>
            <div class="col-md-3">
                <div id="a4">
                <select class="form-control" id="VD" name="VD" disabled="disabled">
                    <option value="">เลือกทั้งหมด</option>
                <% SqlCommand rs_vd = new SqlCommand(sql_vd, objConn); SqlDataReader obj_vd = rs_vd.ExecuteReader(); while (obj_vd.Read()){ %>
                    <option value="<%= obj_vd["VendorID"].ToString() %>"><%= obj_vd["Vendor_Name_En"].ToString() %></option>
                <% } obj_vd.Close(); %>
                </select>
                </div>
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
                    <option value="<%= obj_dc["DC_NO"].ToString() %>"><%= obj_dc["DC_NO"].ToString() %> | <%= obj_dc["DC_Name"].ToString() %></option>
                <% } obj_dc.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Summary Report</label></div>
            <div class="col-md-3">
                <input type="checkbox" id="getReportType02" name="getReportType02" value="1" />
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2" ><label class="control-label"></label></div>
            <div class="col-md-7" ><input type="button" value="Preview" class="btn btn-default" onclick="js_export('YW', 'HL', 'VD', 'DC', '3', 'getReportType02');" id="bt03" />&nbsp;&nbsp;&nbsp;<input type="button" value="Export To Excel" class="btn btn-default" onclick="    js_export('YW', 'HL', 'VD', 'DC', '4', 'getReportType02');" id="bt04" /></div>
        </div>
    </div>
</div>
<div id="form_view03" style="display:none;">
    <div class="form-group">
        <div class="row">
            <div class="col-md-12">
            <h4>Tesco Finance Report > Hualier Cost</h4><hr />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Tesco Year-Week Start</label></div>
            <div class="col-md-3">
                <select class="form-control" id="YW_HC" name="YW_HC" >
                <option value="" selected="selected">กรุณาเลือก</option>
                <% SqlCommand rs_yw_hc = new SqlCommand(sql_yw, objConn); SqlDataReader obj_yw_hc = rs_yw_hc.ExecuteReader(); while (obj_yw_hc.Read())
                   { %>
                    <option value="<%= obj_yw_hc["Tesco_Year"].ToString() %><%= obj_yw_hc["Tesco_Week"].ToString() %>"><%= obj_yw_hc["Tesco_Year"].ToString() %><%= obj_yw_hc["Tesco_Week"].ToString() %> | <%= obj_yw_hc["Between_Date"].ToString() %></option>
                <% } obj_yw_hc.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Tesco Year-Week End</label></div>
            <div class="col-md-3">
                <select class="form-control" id="YW_HCEND" name="YW_HCEND" >
                <option value="" selected="selected">กรุณาเลือก</option>
                <% SqlCommand rs_yw_hcend = new SqlCommand(sql_yw, objConn); SqlDataReader obj_yw_hcend = rs_yw_hcend.ExecuteReader(); while (obj_yw_hcend.Read())
                   { %>
                    <option value="<%= obj_yw_hcend["Tesco_Year"].ToString() %><%= obj_yw_hcend["Tesco_Week"].ToString() %>"><%= obj_yw_hcend["Tesco_Year"].ToString() %><%= obj_yw_hcend["Tesco_Week"].ToString() %> | <%= obj_yw_hcend["Between_Date"].ToString() %></option>
                <% } obj_yw_hcend.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <!--<div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Summary Report</label></div>
            <div class="col-md-3">
                <input type="checkbox" id="getReportType03" name="getReportType03" value="1" />
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>-->
    <div class="form-group">
        <div class="row">
            <div class="col-md-2" ><label class="control-label"></label></div>
            <div class="col-md-7" ><input type="button" value="Preview"  class="btn btn-default" onclick="js_export2('YW_HC', '', '', '', '5', '', 'YW_HCEND');" />&nbsp;&nbsp;&nbsp;<input type="button" value="Export To Excel" class="btn btn-default" onclick="    js_export2('YW_HC', '', '', '', '6', '', 'YW_HCEND');" /></div>
        </div>
    </div>
</div>
<div id="form_view05" style="display:none;">
    <div class="form-group">
        <div class="row">
            <div class="col-md-12">
            <h4>Tesco Finance Report > Vendor Downlaod Log</h4><hr />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Tesco Year-Week</label></div>
            <div class="col-md-3">
                <select class="form-control" id="vdl" name="vdl">
                
                <% SqlCommand rs_vdl = new SqlCommand(sql_yw, objConn); SqlDataReader obj_vdl = rs_vdl.ExecuteReader(); while (obj_vdl.Read())
                   { %>
                    <option value="<%= obj_vdl["Tesco_Year"].ToString() %><%= obj_vdl["Tesco_Week"].ToString() %>"><%= obj_vdl["Tesco_Year"].ToString() %><%= obj_vdl["Tesco_Week"].ToString() %> | <%= obj_vdl["Between_Date"].ToString() %></option>
                <% } obj_vdl.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2" ><label class="control-label"></label></div>
            <div class="col-md-7" ><input type="button" value="Preview" class="btn btn-default" onclick="js_export('vdl', '', '', '', '8', '');" />&nbsp;&nbsp;&nbsp;<input type="button" value="Export To Excel" class="btn btn-default" onclick="    js_export('vdl', '', '', '', '9', '');" /></div>
        </div>
    </div>
</div>
<div id="form_view04" style="display:none;">
    <div class="form-group">
        <div class="row">
            <div class="col-md-12">
            <h4>Tesco Finance Report > Vendor Downlaod Preview</h4><hr />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Tesco Year-Week</label></div>
            <div class="col-md-3">
                <select class="form-control" id="YW_VD" name="YW_VD" onchange="js_revn('YW_VD', 'a5', '', 'User_VD', '');">
                    <option value="" selected="selected">กรุณาเลือก</option>
                <% SqlCommand rs_yw_vd = new SqlCommand(sql_yw, objConn); SqlDataReader obj_yw_vd = rs_yw_vd.ExecuteReader(); while (obj_yw_vd.Read())
                   { %>
                    <option value="<%= obj_yw_vd["Tesco_Year"].ToString() %><%= obj_yw_vd["Tesco_Week"].ToString() %>"  <% if (!string.IsNullOrEmpty(Request.QueryString["yw"] as string)) { if (Request.QueryString["yw"].ToString() == obj_yw_vd["Tesco_Year"].ToString() + obj_yw_vd["Tesco_Week"].ToString()) { Response.Write("selected=\"selected\""); } } %> ><%= obj_yw_vd["Tesco_Year"].ToString() %><%= obj_yw_vd["Tesco_Week"].ToString() %> | <%= obj_yw_vd["Between_Date"].ToString() %></option>
                <% } obj_yw_vd.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Vendor Name</label></div>
            <div class="col-md-3">
                <div id="a5">
                <select class="form-control" id="User_VD" name="User_VD"  <% if (!string.IsNullOrEmpty(Request.QueryString["yw"] as string)) {%>disabled="disabled"<%} %>>
                    <option value="">เลือกทั้งหมด</option>
                <% if (!string.IsNullOrEmpty(Request.QueryString["yw"] as string)) {
                       string sql_userVDa = "select distinct V.VendorID,V.Vendor_Name_En, U.UserID  from Transportation T,Vendor_Info V,Vendor_Group G , User_Profile U where T.Vendor_Code=G.Vendor_Code  and G.VendorID=V.VendorID  and G.vendor_username=U.Username and Year_Week_Upload='" + Request.QueryString["yw"].ToString() + "' and (Calc_Date is not null or Calc_Date<>'') Order by V.Vendor_Name_En"; 
                   SqlCommand rs_userVD = new SqlCommand(sql_userVDa, objConn); SqlDataReader obj_userVD = rs_userVD.ExecuteReader(); while (obj_userVD.Read())
                   { %>
                    <option value="<%= obj_userVD["UserID"].ToString() %>"  <% if (!string.IsNullOrEmpty(Request.QueryString["vd"] as string)) { if (Request.QueryString["vd"].ToString() == obj_userVD["UserID"].ToString()) { Response.Write("selected=\"selected\""); } } %> ><%= obj_userVD["Vendor_Name_En"].ToString() %></option>
                <% } obj_userVD.Close(); }%>
                </select>
                </div>
            </div>
            <div class="col-md-7"></div>    
        </div>
    </div>
    <input type="hidden" id="id" value="<%= Request.QueryString["id"].ToString() %>" />
    <input type="hidden" id="r" value="<%= Request.QueryString["r"].ToString() %>" />

    <div class="form-group">
        <div class="row">
            <div class="col-md-2" ><label class="control-label"></label></div>
            <div class="col-md-7" ><input type="button" value="Preview" id="bt05" class="btn btn-default" onclick="js_export('YW_VD', 'r', 'User_VD', 'id', '7', '');" /></div>
        </div>
    </div>

    <% if (!string.IsNullOrEmpty(Request.QueryString["vd"] as string)){ %>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-bordered">
            <tr style="background-color:#9bbb59;">
                <td style="text-align:center;width:10%;">No.</td>
                <td style="text-align:center;width:40%;">Vendor Code</td>
                <td style="text-align:center;width:25%;">Status</td>
                <td style="text-align:center;width:25%;">Preview</td>
            </tr>
            <%
                string detailColor = "";
                int irows = 0;
                int icolor = 0;
                string sql_download = "select Distinct vendor_code, (select top 1 count(Vendor_Download_Log.DownloadLogID) from Vendor_Download_Log where Vendor_Download_Log.Tesco_Year_Week=transportation.year_week_upload and Vendor_Download_Log.Vendor_UserID=" + Request.QueryString["vd"] + " and Vendor_Download_Log.File_Name=vendor_code+'_" + Request.QueryString["yw"].ToString() + ".xls') as statusDownload from transportation where year_week_upload='" + Request.QueryString["yw"] + "' and calc_date is not null and vendor_code in (select vendor_code from vendor_group where Vendor_UserName= (select UserName from User_Profile where UserID=" + Request.QueryString["vd"] + ") )";
                SqlCommand rs_download = new SqlCommand(sql_download, objConn);
                SqlDataReader obj_download = rs_download.ExecuteReader();
                while (obj_download.Read())
                {
                    irows++;
                    icolor++;
                    if (icolor == 1) { detailColor = "style=\"background-color:#ffffff;\""; } else { detailColor = "style=\"background-color:#f3f3f3;\""; icolor = 0; }
            %>
            <tr <%= detailColor %>>
                <td style="text-align:center;"><%= irows %></td>
                <td style="text-align:center;"><%= obj_download["vendor_code"].ToString() %></td>
                <td style="text-align:center;"><span id="downloadStatus<%=irows %>"><% if (obj_download["statusDownload"].ToString() == "0") { Response.Write("Not Download"); } else { Response.Write("Downloaded"); } %></span></td>
                <td style="text-align:center;"><a href ="./pph_include/perview/vendor_perview.aspx?id=<%=Request.QueryString["vd"].ToString()%>&YW=<%=Request.QueryString["YW"].ToString()%>&VD=<%= obj_download["vendor_code"].ToString() %>" target="_blank">Preview</a></td>  
            </tr>
            <% } obj_download.Close(); %>
            </table>
        </div>
    </div>
    <script>
        document.getElementById('form_view01').style.display = 'none';
        document.getElementById('form_view02').style.display = 'none';
        document.getElementById('form_view03').style.display = 'none';
        document.getElementById('form_view04').style.display = '';
        document.getElementById('form_view05').style.display = 'none';
    </script>
    <% } %>
</div>
<div id="form_view06" style="display:none;">
    <div class="form-group">
        <div class="row">
            <div class="col-md-12">
            <h4>Tesco Finance Report > Export File Primary Transaction</h4><hr />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Tesco Year-Week</label></div>
            <div class="col-md-3">
                <select class="form-control" id="YW_Export" name="YW_Export" onchange="document.getElementById('HL_Export').disabled=false;">
                 <option value="" selected="selected">กรุณาเลือก</option>
                <% SqlCommand rs_yw_export = new SqlCommand(sql_yw, objConn); SqlDataReader obj_yw_export = rs_yw_export.ExecuteReader(); while (obj_yw_export.Read()){ %>
                    <option value="<%= obj_yw_export["Tesco_Year"].ToString() %><%= obj_yw_export["Tesco_Week"].ToString() %>"><%= obj_yw_export["Tesco_Year"].ToString() %><%= obj_yw_export["Tesco_Week"].ToString() %> | <%= obj_yw_export["Between_Date"].ToString() %></option>
                <% } obj_yw_export.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Haulier Name</label></div>
            <div class="col-md-3">
                <div id="a1">
                <select class="form-control" id="HL_Export" name="HL_Export" disabled="disabled">
                    <option value="" selected="selected">เลือกทั้งหมด</option>
                <% SqlCommand rs_hl_export = new SqlCommand(sql_hl, objConn); SqlDataReader obj_hl_export = rs_hl_export.ExecuteReader(); while (obj_hl_export.Read()){ %>
                    <option value="<%= obj_hl_export["Haulier_Abbr"].ToString() %>"><%= obj_hl_export["Haulier_Name_En"].ToString() %></option>
                <% } obj_hl_export.Close(); %>
                </select>
                </div>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2" ><label class="control-label"></label></div>
            <div class="col-md-7" ><input type="button" value="Export To Excel" class="btn btn-default" onclick="js_export('YW_Export', 'HL_Export', '', '', '10', '');" id="btnExportPrimary" /></div>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>
