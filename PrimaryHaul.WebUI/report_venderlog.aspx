<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="report_venderlog.aspx.cs" Inherits="PrimaryHaul.WebUI.report_venderlog" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Import Namespace="PrimaryHaul_WSFlow"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
<script>
    function show_download(varA, varB)
    {
        var YM = document.getElementById('YW').value;
        window.location.href = './report_venderlog.aspx?id=' + varB + '&r=' + varA + '&YW=' + YM;
    }
</script>
<script>
    function js_download(objID, objYW, objVD, objSpan)
    {
        var req = Inint_AJAX();
        var str = Math.random();
        var str_url_address = "./pph_include/ajax/files/vd_download_log.aspx";
        var str_url = "var01=" + objID;
        str_url += "&var02=" + objYW;
        str_url += "&var03=" + objVD;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    document.getElementById(objSpan).innerHTML = 'Downloaded';
                    
                }
            }
        }
        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.send(str_url);
        window.open('./pph_include/download/vendor_file.aspx?id=' + objID + '&YW=' + objYW + '&VD=' + objVD, '_blank');
    }
    function js_downloadAll(obj1, obj2, obj3, obj4) {
        var req = Inint_AJAX();
        var str = Math.random();
        var YM = document.getElementById(obj3).value;
        var total = document.getElementById(obj4).value;
        if (YM == '') { alert('กรุณาเลือก Week '); return false; }else{
            var str_url_address = "./pph_include/ajax/files/vdAll_download_log.aspx";
            var str_url = "var01=" + obj2;
            str_url += "&var02=" + YM;
            str_url += "&clearmemory=" + str;
            req.open('POST', str_url_address, true)
            req.onreadystatechange = function () {
                if (req.readyState == 4) {
                    if (req.status == 200) {
                       
                        var i;
                        for (i=1;i<=total;i++)
                        {
                            var strRes = req.responseText;
                            var countVendor = strRes.split("-");
                            if (countVendor[0] == 0) {
                                alert('ไม่มีไฟล์ให้ Download ค่ะ');
                            } else {
                                document.getElementById('downloadStatus' + i).innerHTML = 'Downloaded';
                                var arrVendor = countVendor[1].split("|");
                                var iVD;
                                for (iVD = 1; iVD <= countVendor[0]; iVD++) {
                                    window.open('./pph_include/download/vendor_file.aspx?id=' + obj2 + '&YW=' + YM + '&VD=' + arrVendor[iVD], '_blank');
                                }
                            }
                        }
                    }
                }
            }
            req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            req.send(str_url);
            
        }
    }
</script>
<% string strYW = ""; if (!string.IsNullOrEmpty(Request.QueryString["YW"] as string)) { strYW = Request.QueryString["YW"].ToString(); } %>
<div class="row"><div class="col-md-12"><div class="form-horizontal"><h4>Vendor > Download</h4><hr /></div></div></div>
<div class="form-group">
<div class="row">
    <div class="col-md-1"><label class="control-label">Week </label></div>
    <div class="col-md-3">
        <select class="form-control" id="YW" name="YW" style="width:100%;">
            <% while (obj_list.Read())
               { %>
                <option value="<%= obj_list["Tesco_Year"].ToString() %><%= obj_list["Tesco_Week"].ToString() %>" <%if (obj_list["Tesco_Year"].ToString() + obj_list["Tesco_Week"].ToString() == strYW) { Response.Write("selected=\"selected\""); }%>><%= obj_list["Tesco_Year"].ToString() %><%= obj_list["Tesco_Week"].ToString() %> | <%= obj_list["Between_Date"].ToString() %></option>
            <% } obj_list.Close(); %>
        </select>
    </div>
    <div class="col-md-2"><input type="button" id="btnSubmitEdit" value="View" class="btn btn-default"  <% Response.Write("onclick=\"show_download('" + Request.QueryString["r"].ToString() + "', '" + Request.QueryString["id"].ToString() + "');\""); %> /></div>
    <div class="col-md-2"><input type="button" id="btnDownloadAll" value="Download All File" class="btn btn-default" <% Response.Write("onclick=\"js_downloadAll('" + Request.QueryString["r"].ToString() + "', '" + Request.QueryString["id"].ToString() + "', 'YW', 'totalRows');\""); %> /></div>
</div>
</div>
<% if (!string.IsNullOrEmpty(Request.QueryString["YW"] as string)){ %>
<div class="row">
<div class="col-md-12">
    <table class="table table-bordered">
    <tr style="background-color:#9bbb59;">
        <td style="text-align:center;width:10%;">No.</td>
        <td style="text-align:center;width:30%;">Vendor Code</td>
        <td style="text-align:center;width:20%;">Status</td>
        <td style="text-align:center;width:20%;">Perview</td>
         <td style="text-align:center;width:20%;">Download</td>
    </tr>
    <%
        string detailColor = "";
        int irows = 0;
        int icolor = 0;
        string sql_download = "select Distinct vendor_code,vendor_name, (select top 1 count(Vendor_Download_Log.DownloadLogID) from Vendor_Download_Log where Vendor_Download_Log.Tesco_Year_Week=transportation.year_week_upload and Vendor_Download_Log.Vendor_UserID=" + Request.QueryString["id"] + " and Vendor_Download_Log.File_Name=vendor_code+'_" + Request.QueryString["YW"].ToString() + ".xls') as statusDownload from transportation where year_week_upload='" + Request.QueryString["YW"] + "' and calc_date is not null and vendor_code in (select vendor_code from vendor_group where Vendor_UserName= (select UserName from User_Profile where UserID=" + Request.QueryString["id"] + ") )";
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
        <td style="text-align:center;"><a href ="./pph_include/perview/vendor_perview.aspx?id=<%=Request.QueryString["id"].ToString()%>&YW=<%=Request.QueryString["YW"].ToString()%>&VD=<%= obj_download["vendor_code"].ToString() %>" target="_blank">Perview</a></td>  
        <td style="text-align:center;"><a href ="javascript:void(0);" <% Response.Write("onclick=\"js_download('"+Request.QueryString["id"].ToString()+"', '"+Request.QueryString["YW"].ToString()+"', '"+obj_download["vendor_code"].ToString()+"', 'downloadStatus"+irows+"');\""); %> target="_blank">Download</a></td>                  
        </tr>
        <% } obj_download.Close(); %>
    </table>
    <input type="hidden" id="totalRows" name="totalRows" value="<%= irows %>" />
</div>
</div>
<% } %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>
