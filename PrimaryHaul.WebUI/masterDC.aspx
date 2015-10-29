<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="masterDC.aspx.cs" Inherits="PrimaryHaul.WebUI.masterDC" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
<script>
    function js_tab(varTab) {
        document.getElementById('form_view').style.display = 'none';
        document.getElementById('form_add').style.display = 'none';
        document.getElementById(varTab).style.display = '';
    }
    function js_dcForm(varUrl, varTax, varDate) {
        strUrl = document.getElementById(varUrl).value;
        window.location.href = strUrl + '&DC_NO=' + varTax + '&DC_Date=' + varDate;
    }
    function donKeydown(evt) {
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode)
            return false;
    }
</script>
  <link rel="stylesheet" href="./pph_include/css/jquery-ui.min.css" />  
<div id="form_button">
<div class="row">
    <div class="col-md-4"><% if(PH_EncrptHelper.MD5Decryp(Request.Cookies["PH_RoleUserCookie"].Value) == "A1"){ %><input type="button" value="Add" class="btn btn-default" onclick="js_tab('form_add');" />&nbsp;&nbsp;&nbsp;<% } %><input type="button" value="View Data" class="btn btn-default" onclick="js_tab('form_view');" /></div>
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
            <td style="text-align:center;width:15%;">DC No.</td>
            <td style="text-align:center;width:15%;">DC Abbr</td>
            <td style="text-align:center;width:30%;">DC Name</td>
            <td style="text-align:center;width:20%;">End Date</td>
            <td style="text-align:center;width:10%;"></td>
        </tr>
        <%
            string detailColor = "";
            int irows = 0;
            int icolor = 0;
            string sql_dcInfo = "select DC_NO, DC_Name, CONVERT(varchar(11),EndDate,103) as EndDate, dc_abbr from DC_Info  order by DC_NO asc";
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
            <td style="text-align:center;"><%= obj_dcInfo["dc_abbr"].ToString() %></td>
            <td style="text-align:left;"><%= obj_dcInfo["DC_Name"].ToString() %></td>
            <td style="text-align:center;"><%= obj_dcInfo["EndDate"].ToString() %></td>
            <td style="text-align:center;">
                <% if(PH_EncrptHelper.MD5Decryp(Request.Cookies["PH_RoleUserCookie"].Value) == "A1"){ %><input type="button" value="Update" class="btn btn-default" <% Response.Write("onclick=\"js_dcForm('urlSubmit', '" + obj_dcInfo["DC_NO"].ToString() + "', '" +obj_dcInfo["EndDate"].ToString()+ "');\""); %> /><%} %>                
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
        if (strTax.length == 3) {
            document.getElementById('btnSubmit').disabled = true;
            document.getElementById('taxError').innerHTML = "<font color=\"red\">TAX ID must be 3 digit</font>";
            document.getElementById('taxError').style.display = "";
            document.getElementById('btnSubmitError').style.display = "none";
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
        else
        {
            document.getElementById('btnSubmit').disabled = true;
            document.getElementById('taxError').innerHTML = "<font color=\"red\">DC No. must be 13 digit</font>";
            document.getElementById('taxError').style.display = "";
            document.getElementById('btnSubmitError').style.display = "none";
        }
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

    function dc_abbrDuplicate() {
        var req = Inint_AJAX();
        var str = Math.random();
        var strNameEn = document.getElementById('dc_abbr').value;
        var str_url_address = "./pph_include/ajax/files/dc_abbrDuplicate.aspx";
        var str_url = "var01=" + strNameEn;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    var strRes = req.responseText;
                    if (strRes > "0") {
                        document.getElementById('btnSubmit').disabled = true;
                        document.getElementById('abbrError').innerHTML = "<font color=\"red\">Duplicate dc abbr</font>";
                        document.getElementById('abbrError').style.display = "";
                        document.getElementById('btnSubmitError').style.display = "none";
                    }
                    else {
                        document.getElementById('btnSubmit').disabled = false;
                        document.getElementById('abbrError').style.display = "none";
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
        var strAbbr = document.getElementById('dc_abbr').value;
        if (strTax != '') {
            var str_url_address = "./pph_include/ajax/files/dc_Submit.aspx";
            var str_url = "var01=" + strTax;
            str_url += "&var02=" + strName;
            str_url += "&var03=" + strAbbr;
            str_url += "&clearmemory=" + str;
            req.open('POST', str_url_address, true)
            req.onreadystatechange = function () {
                if (req.readyState == 4) {
                    if (req.status == 200) {
                        document.getElementById('btnSubmit').disabled = false;
                        document.getElementById('btnSubmitError').style.display = "none";
                        document.getElementById('DC_NO').value = "";
                        document.getElementById('DC_Name').value = "";
                        document.getElementById('dc_abbr').value = "";
                        alert('Save Success');
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
     <div class="col-md-12">
        <h4>Master Data > DC > ADD</h4>
        <hr />   
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">DC NO </label></div>
                <div class="col-md-3">
                    <input type="text" class="form-control" name="DC_NO" id="DC_NO" onkeypress='return isNumberKey(event)'  onchange="dc_noDuplicate();" maxlength="3" />
                    <p class="text-danger" id="taxError" style="display:none;"></p>
                </div>
                <div class="col-md-7"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">DC Name </label></div>
                <div class="col-md-5"><input type="text" class="form-control" name="DC_Name" id="DC_Name"  style="width:100%;"/><p class="text-danger" id="nameEnError" style="display:none;"></p></div>               
                <div class="col-md-5"></div>
            </div>
        </div> 
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">DC Abbr </label></div>
                <div class="col-md-5"><input type="text" class="form-control" name="dc_abbr" id="dc_abbr"  style="width:100%;"/><p class="text-danger" id="abbrError" style="display:none;"></p></div>               
                <div class="col-md-5"></div>
            </div>
        </div>  
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" style="text-align:right;"></div>
                <div class="col-md-3" style="text-align:left;"><input type="button" id="btnSubmit" value="Save" class="btn btn-default" onclick="dc_Submit();" /><p class="text-danger" id="btnSubmitError" style="display:none;"></p></div>
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
<%
       string sql_dc = "select DC_Name,  CONVERT(varchar(11),EndDate,103) as EndDate, dc_abbr from DC_Info  where DC_NO ='" + Request.QueryString["DC_NO"] + "'";
    SqlCommand rs_dc = new SqlCommand(sql_dc, objConn);
    SqlDataReader obj_dc = rs_dc.ExecuteReader();
    obj_dc.Read();
%>
<script>
    function dc_nameEditDuplicate() {
        var req = Inint_AJAX();
        var str = Math.random();
        var strNameEn = document.getElementById('DC_NameEdit').value;
        var str_url_address = "./pph_include/ajax/files/dc_nameEditDuplicate.aspx";
        var str_url = "var01=" + strNameEn;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    var strRes = req.responseText;
                    if (strRes > "0") {
                        document.getElementById('btnSubmitEdit').disabled = true;
                        document.getElementById('nameEnErrorEdit').innerHTML = "<font color=\"red\">Duplicate dc Name</font>";
                        document.getElementById('nameEnErrorEdit').style.display = "";
                        document.getElementById('btnEditSubmitError').style.display = "none";
                    }
                    else {
                        document.getElementById('btnSubmitEdit').disabled = false;
                        document.getElementById('nameEnErrorEdit').style.display = "none";
                        document.getElementById('btnEditSubmitError').style.display = "none";
                    }
                }
            }
        }
        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.send(str_url);
    }

    function dc_abbrEditDuplicate() {
        var req = Inint_AJAX();
        var str = Math.random();
        var strNameEn = document.getElementById('dc_abbrEdit').value;
        var str_url_address = "./pph_include/ajax/files/dc_abbrDuplicate.aspx";
        var str_url = "var01=" + strNameEn;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    var strRes = req.responseText;
                    if (strRes > "0") {
                        document.getElementById('btnSubmitEdit').disabled = true;
                        document.getElementById('abbrEditError').innerHTML = "<font color=\"red\">Duplicate dc abbr</font>";
                        document.getElementById('abbrEditError').style.display = "";
                        document.getElementById('btnEditSubmitError').style.display = "none";
                    }
                    else {
                        document.getElementById('btnSubmitEdit').disabled = false;
                        document.getElementById('abbrEditError').style.display = "none";
                        document.getElementById('btnEditSubmitError').style.display = "none";
                    }
                }
            }
        }
        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.send(str_url);
    }

    function dc_EditSubmit(varA, varB) {
        var req = Inint_AJAX();
        var str = Math.random();
        var strTax = document.getElementById('hid_DC_NO').value;
        var strName = document.getElementById('DC_NameEdit').value;
        var strdateEnd = document.getElementById('dateEnd').value;
        var strAbbr = document.getElementById('dc_abbrEdit').value;
        if (strName != '' && strAbbr != '') {
            var str_url_address = "./pph_include/ajax/files/dc_EditSubmit.aspx";
            var str_url = "var01=" + strTax;
            str_url += "&var02=" + strName;
            str_url += "&var03=" + strdateEnd;
            str_url += "&var04=" + strAbbr;
            str_url += "&clearmemory=" + str;
            req.open('POST', str_url_address, true)
            req.onreadystatechange = function () {
                if (req.readyState == 4) {
                    if (req.status == 200) {
                        document.getElementById('btnSubmitEdit').disabled = false;
                        document.getElementById('btnEditSubmitError').style.display = "none";
                        alert('Save Success');
                        window.location.href = './masterDC.aspx?r=' + varA + '&id=' + varB;
                    }
                }
            }
            req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            req.send(str_url);
        }
        else {
            document.getElementById('btnSubmitEdit').disabled = true;
            document.getElementById('btnEditSubmitError').innerHTML = "<font color=\"red\">field is required</font>";
            document.getElementById('btnEditSubmitError').style.display = "";
        }
    }
    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        return true;
    }
    document.getElementById('nameEnErrorEdit').style.display = "none";
    document.getElementById('btnEditSubmitError').style.display = "none";
</script>
<div class="row">
     <div class="col-md-12">
        <h4>Master Data > DC > Update</h4>
        <hr />   
         <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">DC Name </label></div>
                <div class="col-md-5"><input type="text" class="form-control" autocomplete="off" name="DC_NameEdit" id="DC_NameEdit" value="<%=obj_dc[0].ToString() %>" style="width:100%;"/><p class="text-danger" id="nameEnErrorEdit" style="display:none;"></p></div>               
                <div class="col-md-5"></div>
            </div>
        </div>   
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">DC Abbr </label></div>
                <div class="col-md-5"><input type="text" class="form-control" name="dc_abbrEdit" id="dc_abbrEdit" style="width:100%;" value="<%=obj_dc[2].ToString() %>" /><p class="text-danger" id="abbrEditError" style="display:none;"></p></div>               
                <div class="col-md-5"></div>
            </div>
        </div>  
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">End Date </label></div>
                <div class="col-md-3">
                    <input type="hidden" class="form-control" id="hid_DC_NO" name="hid_DC_NO" value="<%= Request.QueryString["DC_NO"] %>" />
                    <input type="text" class="form-control" onkeypress="return donKeydown(event)" autocomplete="off" name="dateEnd" id="dateEnd" style="width:100%;" value="<%=obj_dc[1].ToString() %>" />
                </div>
                <div class="col-md-7"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" style="text-align:right;"></div>
                <div class="col-md-3" style="text-align:left;"><input type="button" id="btnSubmitEdit" value="Save" class="btn btn-default"  <% Response.Write("onclick=\"dc_EditSubmit('" + Request.QueryString["r"].ToString() + "', '" + Request.QueryString["id"].ToString() + "');\""); %> /><p class="text-danger" id="btnEditSubmitError" style="display:none;"></p></div>
                <div class="col-md-7" style="text-align:left;"></div>
            </div>
        </div>
    </div>
</div>
</div>
<% } %>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
 <script src="./pph_include/jquery/jquery-ui.js"></script>
    
    <script>

        $(function () {

            $("#dateEnd").datepicker({ dateFormat: 'dd/mm/yy', minDate: 0 });
        });

    </script>
    <style>
        div.ui-datepicker{
         font-size:14px;
        }
    </style>  
</asp:Content>

