<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="masterDC.aspx.cs" Inherits="PrimaryHaul.WebUI.masterDC" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
<script>
    function js_tab(varTab) {
        document.getElementById('form_view').style.display = 'none';
        document.getElementById('form_add').style.display = 'none';
        document.getElementById(varTab).style.display = '';
    }
    function js_dcForm(varUrl, varTax) {
        strUrl = document.getElementById(varUrl).value;
        window.location.href = strUrl + '&DC_NO=' + varTax;
    }
</script>
<div id="form_button">
<div class="row">
    <div class="col-md-2"><input type="button" value="Add" class="btn btn-default" onclick="js_tab('form_add');" style="width:100%;" /></div>
    <div class="col-md-2"><input type="button" value="View Data" class="btn btn-default" onclick="js_tab('form_view');" style="width:100%;" /></div>
    <div class="col-md-8"></div>
</div>
<br />
</div>
<input type="hidden" name="urlSubmit" id="urlSubmit" value="<%= HttpContext.Current.Request.Url.AbsolutePath %>?r=<%= Request.QueryString["r"].ToString() %>&id=<%= Request.QueryString["id"].ToString() %>" />
<div id="form_view">
<div class="row">
    <div class="col-md-12">
        <h4>Master Data > DC</h4>
        <hr />
        <table class="table table-bordered">
        <tr style="background-color:#9bbb59;">
            <td style="text-align:center;width:10%;">No.</td>
            <td style="text-align:center;width:30%;">DC No.</td>
            <td style="text-align:center;width:30%;">DC Name</td>
            <td style="text-align:center;width:20%;">End Date</td>
            <td style="text-align:center;width:10%;"></td>
        </tr>
        <%
            string detailColor = "";
            int irows = 0;
            int icolor = 0;
            string sql_dcInfo = "select DC_NO, DC_Name, CONVERT(varchar(11),EndDate,103) as EndDate from DC_Info  order by DC_NO desc";
            SqlCommand rs_dcInfo = new SqlCommand(sql_dcInfo, objConn);
            SqlDataReader obj_dcInfo = rs_dcInfo.ExecuteReader();
            while (obj_dcInfo.Read())
            {
                irows++;
                icolor++;
                if (icolor == 1) { detailColor = "style=\"background-color:#ffffff;\""; } else { detailColor = "style=\"background-color:#f3f3f3;\""; icolor = 0; }
        %>
          <tr <%= detailColor %>>
            <td style="text-align:center;"><%= irows %></td>
            <td style="text-align:center;"><%= obj_dcInfo["DC_NO"].ToString() %></td>
            <td style="text-align:left;"><%= obj_dcInfo["DC_Name"].ToString() %></td>
            <td style="text-align:center;"><%= obj_dcInfo["EndDate"].ToString() %></td>
            <td style="text-align:center;">
                <input type="button" value="Update" class="btn btn-default" <% Response.Write("onclick=\"js_dcForm('urlSubmit', '" + obj_dcInfo["DC_NO"].ToString() + "');\""); %> />
                 
            </td>                   
          </tr>
         <% } obj_dcInfo.Close(); %>
        </table>
        </div>
    </div>
</div>

<div id="form_add" style="display:none;">
<script>
    function dc_noDuplicate() {
        var req = Inint_AJAX();
        var str = Math.random();
        var strTax = document.getElementById('DC_NO').value;
        var str_url_address = "./pph_include/ajax/files/dc_noDuplicate.aspx";
        var str_url = "var01=" + strTax;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    var strRes = req.responseText;
                    if (strRes > "0") {
                        document.getElementById('btnSubmit').disabled = true;
                        document.getElementById('taxError').innerHTML = "<font color=\"red\">Duplicate DC No.</font>";
                        document.getElementById('taxError').style.display = "";
                        document.getElementById('btnSubmitError').style.display = "none";
                    }
                    else {
                        document.getElementById('btnSubmit').disabled = false;
                        document.getElementById('taxError').style.display = "none";
                        document.getElementById('btnSubmitError').style.display = "none";
                    }
                }
            }
        }
        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.send(str_url);
    }

    function dc_nameDuplicate() {
        var req = Inint_AJAX();
        var str = Math.random();
        var strNameEn = document.getElementById('DC_Name').value;
        var str_url_address = "./pph_include/ajax/files/dc_nameDuplicate.aspx";
        var str_url = "var01=" + strNameEn;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    var strRes = req.responseText;
                    if (strRes > "0") {
                        document.getElementById('btnSubmit').disabled = true;
                        document.getElementById('nameEnError').innerHTML = "<font color=\"red\">Duplicate dc Name</font>";
                        document.getElementById('nameEnError').style.display = "";
                        document.getElementById('btnSubmitError').style.display = "none";
                    }
                    else {
                        document.getElementById('btnSubmit').disabled = false;
                        document.getElementById('nameEnError').style.display = "none";
                        document.getElementById('btnSubmitError').style.display = "none";
                    }
                }
            }
        }
        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.send(str_url);
    }

    
    function dc_Submit() {
        var req = Inint_AJAX();
        var str = Math.random();
        var strTax = document.getElementById('DC_NO').value;
        var strName = document.getElementById('DC_Name').value;
        if (strTax != '' || strName != '' ) {
            var str_url_address = "./pph_include/ajax/files/dc_Submit.aspx";
            var str_url = "var01=" + strTax;
            str_url += "&var02=" + strName;
            str_url += "&clearmemory=" + str;
            req.open('POST', str_url_address, true)
            req.onreadystatechange = function () {
                if (req.readyState == 4) {
                    if (req.status == 200) {
                        document.getElementById('btnSubmit').disabled = false;
                        document.getElementById('btnSubmitError').innerHTML = "<font color=\"red\">Submit Success</font>";
                        document.getElementById('btnSubmitError').style.display = "";
                        document.getElementById('DC_NO').value = "";
                        document.getElementById('DC_Name').value = "";
                        window.location.reload()
                    }
                }
            }
            req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            req.send(str_url);
        }
        else {
            document.getElementById('btnSubmit').disabled = true;
            document.getElementById('btnSubmitError').innerHTML = "<font color=\"red\">field is required</font>";
            document.getElementById('btnSubmitError').style.display = "";
        }
    }
    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        return true;
    }
    document.getElementById('taxError').style.display = "none";
    document.getElementById('nameEnError').style.display = "none";
    document.getElementById('btnSubmitError').style.display = "none";
</script>
<div class="row">
    <div class="form-horizontal">
        <h4>Master Data > DC > Add</h4>
        <hr />   
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" style="text-align:right;"><label class="control-label">DC NO : </label></div>
                <div class="col-md-3">
                    <input type="text" class="form-control" name="DC_NO" id="DC_NO" onkeypress='return isNumberKey(event)'  onchange="dc_noDuplicate();" />
                    <p class="text-danger" id="taxError" style="display:none;"></p>
                </div>
                <div class="col-md-7"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" style="text-align:right;"><label class="control-label">DC Name : </label></div>
                <div class="col-md-5"><input type="text" class="form-control" name="DC_Name" id="DC_Name" onchange="dc_nameDuplicate();" style="width:100%;"/><p class="text-danger" id="nameEnError" style="display:none;"></p></div>               
                <div class="col-md-5"></div>
            </div>
        </div>   
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" style="text-align:right;"></div>
                <div class="col-md-3" style="text-align:left;"><input type="button" id="btnSubmit" value="Submit" class="btn btn-default" onclick="dc_Submit();" /><p class="text-danger" id="btnSubmitError" style="display:none;"></p></div>
                <div class="col-md-7" style="text-align:left;"></div>
            </div>
        </div>
    </div>
</div>
</div>
<input type="hidden" class="form-control" id="urlHidden" name="urlHidden" runat="server" />
<% if (!string.IsNullOrEmpty(Request.QueryString["DC_NO"] as string)){ %>
<script>
    document.getElementById('form_view').style.display = 'none';
    document.getElementById('form_add').style.display = 'none';
    document.getElementById('form_button').style.display = 'none';
</script>
<div class="row">
    <div class="col-md-2"><input type="button" value="Back" class="btn btn-default" onclick="window.history.back();" style="width:100%;" /></div>
    <div class="col-md-2"></div>
    <div class="col-md-8"></div>
</div>
<br />
<div id="form_db">
<div class="row">
    <div class="form-horizontal">
        <h4>Master Data > DC > Update</h4>
        <hr />   
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" style="text-align:right;"><label class="control-label">End Date : </label></div>
                <div class="col-md-3">
                    <input type="hidden" class="form-control" id="hid_DC_NO" name="hid_DC_NO" runat="server" />
                     <asp:TextBox autocomplete="off" runat="server" ID="txt_enddate" CssClass="form-control" /><br />
                    <asp:CalendarExtender ID="calendar_enddate" Format="dd/MM/yyyy" runat="server" TargetControlID="txt_enddate" />
                </div>
                <div class="col-md-7"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" style="text-align:right;"></div>
                <div class="col-md-3" style="text-align:left;"> <asp:Button runat="server" ID="btnEdit" Text="Submit" CssClass="btn btn-default" OnClick="btnEdit_Click" /></div>
                <div class="col-md-7" style="text-align:left;"></div>
            </div>
        </div>
    </div>
</div>
</div>
<% } %>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>

