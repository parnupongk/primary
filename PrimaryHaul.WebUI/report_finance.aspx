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
        document.getElementById(varTab).style.display = '';
    }
    function js_export(yw, hl, vd, dc, type) {
        var objyw = '';
        var objhl = '';
        var objvd = '';
        var objdc = '';
        objyw = document.getElementById(yw).value;
        if (type == 1)
        {
            objhl = document.getElementById(hl).value;
            objvd = document.getElementById(vd).value;
            window.open('./pph_include/perview/report_summary.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd, '_blank');
        }
        if (type == 2) {
            objhl = document.getElementById(hl).value;
            objvd = document.getElementById(vd).value;
            window.open('./pph_include/download/report_summary.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd, '_blank');
        }
        if (type == 3) {
            objhl = document.getElementById(hl).value;
            objvd = document.getElementById(vd).value;
            objdc = document.getElementById(dc).value;
            window.open('./pph_include/perview/report.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd + '&dc=' + objdc, '_blank');
        }
        if (type == 4) {
            objhl = document.getElementById(hl).value;
            objvd = document.getElementById(vd).value;
            objdc = document.getElementById(dc).value;
            window.open('./pph_include/download/report.aspx?yw=' + objyw + '&hl=' + objhl + '&vd=' + objvd + '&dc=' + objdc, '_blank');
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
            <div class="col-md-12">
            <h4>Tesco Finance Report > Vendor Cost</h4><hr />
            </div>
        </div>
    </div>
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
                    <option value="<%= obj_dc["DC_NO"].ToString() %>"><%= obj_dc["DC_Name"].ToString() %></option>
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
            <div class="col-md-2"><label class="control-label">Tesco Year-Week</label></div>
            <div class="col-md-3">
                <select class="form-control" id="YW_HC" name="YW_HC">
                
                <% SqlCommand rs_yw_hc = new SqlCommand(sql_yw, objConn); SqlDataReader obj_yw_hc = rs_yw_hc.ExecuteReader(); while (obj_yw_hc.Read())
                   { %>
                    <option value="<%= obj_yw_hc["Tesco_Year"].ToString() %><%= obj_yw_hc["Tesco_Week"].ToString() %>"><%= obj_yw_hc["Between_Date"].ToString() %></option>
                <% } obj_yw_hc.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2" ><label class="control-label"></label></div>
            <div class="col-md-7" ><input type="button" value="Perview" class="btn btn-default" onclick="js_export('YW_HC', '', '', '', '5');" />&nbsp;&nbsp;&nbsp;<input type="button" value="Export To Excel" class="btn btn-default" onclick="js_export('YW_HC', '', '', '', '6');" /></div>
        </div>
    </div>
</div>
<div id="form_view04" style="display:none;">
    <div class="form-group">
        <div class="row">
            <div class="col-md-12">
            <h4>Tesco Finance Report > Vendor Downlaod Perview</h4><hr />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Tesco Year-Week</label></div>
            <div class="col-md-3">
                <select class="form-control" id="YW_VD" name="YW_VD">
                
                <% SqlCommand rs_yw_vd = new SqlCommand(sql_yw, objConn); SqlDataReader obj_yw_vd = rs_yw_vd.ExecuteReader(); while (obj_yw_vd.Read())
                   { %>
                    <option value="<%= obj_yw_vd["Tesco_Year"].ToString() %><%= obj_yw_vd["Tesco_Week"].ToString() %>"><%= obj_yw_vd["Between_Date"].ToString() %></option>
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
                <select class="form-control" id="User_VD" name="User_VD">
                    <option value="">กรุณาเลือก</option>
                <% SqlCommand rs_userVD = new SqlCommand(sql_userVD, objConn); SqlDataReader obj_userVD = rs_userVD.ExecuteReader(); while (obj_userVD.Read())
                   { %>
                    <option value="<%= obj_userVD["UserID"].ToString() %>"  <% if (!string.IsNullOrEmpty(Request.QueryString["vd"] as string)) { if (Request.QueryString["vd"].ToString() == obj_userVD["UserID"].ToString()) { Response.Write("selected=\"selected\""); } } %> ><%= obj_userVD["FullName_En"].ToString() %></option>
                <% } obj_userVD.Close(); %>
                </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <input type="hidden" id="id" value="<%= Request.QueryString["id"].ToString() %>" />
    <input type="hidden" id="r" value="<%= Request.QueryString["r"].ToString() %>" />

    <div class="form-group">
        <div class="row">
            <div class="col-md-2" ><label class="control-label"></label></div>
            <div class="col-md-7" ><input type="button" value="Perview" class="btn btn-default" onclick="js_export('YW_VD', 'r', 'User_VD', 'id', '7');" /></div>
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
                <td style="text-align:center;width:25%;">Perview</td>
            </tr>
            <%
                string detailColor = "";
                int irows = 0;
                int icolor = 0;
                string sql_download = "select Distinct vendor_code,vendor_name, (select top 1 count(Vendor_Download_Log.DownloadLogID) from Vendor_Download_Log where Vendor_Download_Log.Tesco_Year_Week=transportation.year_week_upload and Vendor_Download_Log.Vendor_UserID=" + Request.QueryString["vd"] + " and Vendor_Download_Log.File_Name=vendor_code+'_" + Request.QueryString["YW"].ToString() + ".xls') as statusDownload from transportation where year_week_upload='" + Request.QueryString["YW"] + "' and calc_date is not null and vendor_code in (select vendor_code from vendor_group where Vendor_UserName= (select UserName from User_Profile where UserID=" + Request.QueryString["vd"] + ") )";
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
                <td style="text-align:center;"><a href ="./pph_include/perview/vendor_perview.aspx?id=<%=Request.QueryString["vd"].ToString()%>&YW=<%=Request.QueryString["YW"].ToString()%>&VD=<%= obj_download["vendor_code"].ToString() %>" target="_blank">Perview</a></td>  
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
    </script>
    <% } %>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>
