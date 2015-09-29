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
<% string strYW = ""; if (!string.IsNullOrEmpty(Request.QueryString["YW"] as string)) { strYW = Request.QueryString["YW"].ToString(); } %>
<div class="row"><div class="col-md-12"><div class="form-horizontal"><h4>Vendor > Download</h4><hr /></div></div></div>
<div class="form-group">
<div class="row">
    <div class="col-md-2"><label class="control-label">Week </label></div>
    <div class="col-md-3">
        <select class="form-control" id="YW" name="YW" >
            <% while (obj_list.Read())
               { %>
                <option value="<%= obj_list["Tesco_Year"].ToString() %><%= obj_list["Tesco_Week"].ToString() %>" <%if (obj_list["Tesco_Year"].ToString() + obj_list["Tesco_Week"].ToString() == strYW) { Response.Write("selected=\"selected\""); }%>><%= obj_list["Between_Date"].ToString() %></option>
            <% } obj_list.Close(); %>
        </select>
    </div>
    <div class="col-md-2"><input type="button" id="btnSubmitEdit" value="Show" class="btn btn-default"  <% Response.Write("onclick=\"show_download('" + Request.QueryString["r"].ToString() + "', '" + Request.QueryString["id"].ToString() + "');\""); %> /></div>
</div>
</div>
<div class="form-group">
<div class="row">
<div class="col-md-2"><input type="button" id="btnDownloadAll" value="Download All File" class="btn btn-default" /></div>
</div>
</div>
<% if (!string.IsNullOrEmpty(Request.QueryString["YW"] as string)){ %>
<div class="row">
<div class="col-md-12">
    <table class="table table-bordered">
    <tr style="background-color:#9bbb59;">
        <td style="text-align:center;width:10%;">No.</td>
        <td style="text-align:center;width:40%;">Vendor Code</td>
        <td style="text-align:center;width:30%;">Download</td>
        <td style="text-align:center;width:20%;"></td>
    </tr>
    <%
        string detailColor = "";
        int irows = 0;
        int icolor = 0;
        string sql_download = "select Distinct VD.Vendor_Code as VD, Case  When (T.Calc_Date is NULL) and (isnull(Year_Week_Upload,'No')='No') Then 'Not Upload' When (T.Calc_Date is NULL) and (isnull(Year_Week_Upload,'No')<>'No') Then 'Not Calculate'  Else 'Waiting' End As Status_Download,T.Year_Week_Upload,Calc_Date from ( Select B.Vendor_Code,B.Vendor_Username From Vendor_Info A , vendor_group B Where A.VendorID=B.VendorID  and B.Vendor_UserName=(select UserName from User_Profile where UserID="+Request.QueryString["id"]+")) VD LEFT OUTER JOIN  Transportation T ON VD.Vendor_Code=T.Vendor_code and T.Year_Week_Upload='" + Request.QueryString["YW"].ToString() + "' Order by VD.Vendor_Code Asc";
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
        <td style="text-align:center;"><%= obj_download["VD"].ToString() %></td>
        <td style="text-align:center;"><%= obj_download["Status_Download"].ToString() %></td>
        <td style="text-align:center;">
            <input type="button" value="Download" class="btn btn-default" <%if (obj_download["Status_Download"].ToString() == "Not Upload") { Response.Write("disabled=\"disabled\""); } else if (obj_download["Status_Download"].ToString() == "Not Calculate") { Response.Write("disabled=\"disabled\""); } else { } %> />
            <br />
            <a href ="./pph_include/download/vendor_file.aspx?id=<%=Request.QueryString["id"].ToString()%>&YW=<%=Request.QueryString["YW"].ToString()%>&VD=<%= obj_download["VD"].ToString() %>" target="_blank">test</a>  
        </td>                   
        </tr>
        <% } obj_download.Close(); %>
    </table>
    <a href="./sss.html">dsdf</a>
</div>
</div>
<% } %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>
