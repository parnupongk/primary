<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="master_vender.aspx.cs" Inherits="PrimaryHaul.WebUI.master_vender" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
<script>
    function js_tab(varTab) {
        document.getElementById('form_view').style.display = 'none';
        document.getElementById('form_add').style.display = 'none';
        document.getElementById(varTab).style.display = '';
    }
    function js_submitSearch(varEn, varTh, varTax, varUrl) {
        strEn = document.getElementById(varEn).value;
        strTh = document.getElementById(varTh).value;
        strTax = document.getElementById(varTax).value;
        strUrl = document.getElementById(varUrl).value;
        window.location.href = strUrl + '&seNameEn=' + strEn + '&seNameTh=' + strTh + '&seNameTax=' + strTax;
    }
    function js_clearSearch(varUrl)
    {
        strUrl = document.getElementById(varUrl).value;
        window.location.href = strUrl;
    }
    function js_venderForm(varUrl, varTax, varID) {
        strUrl = document.getElementById(varUrl).value;
        window.location.href = strUrl + '&taxID=' + varTax + '&vnID=' + varID;
    }
</script>
<div id="form_button">
<div class="row">
    <% if(PH_EncrptHelper.MD5Decryp(Request.Cookies["PH_RoleUserCookie"].Value) == "A1"){ %><div class="col-md-2"><input type="button" value="Add" class="btn btn-default" onclick="js_tab('form_add');" style="width:100%;" /></div><% } %>
    <div class="col-md-2"><input type="button" value="View Data" class="btn btn-default" onclick="js_tab('form_view');" style="width:100%;" /></div>
    <div class="col-md-8"></div>
</div>
<br />
</div>

<input type="hidden" name="urlSubmit" id="urlSubmit" value="<%= HttpContext.Current.Request.Url.AbsolutePath %>?r=<%= Request.QueryString["r"].ToString() %>&id=<%= Request.QueryString["id"].ToString() %>" />
<div id="form_view">
<div class="row">
    <div class="col-md-12">
        <h4>Master Data > Vender</h4>
        <hr />
        <%
            string str_sNameEn = "", str_sNameTh = "", str_sNameTax = "";
            if (!string.IsNullOrEmpty(Request.QueryString["seNameEn"] as string)) { str_sNameEn = Request.QueryString["seNameEn"].ToString(); }
            if (!string.IsNullOrEmpty(Request.QueryString["seNameTh"] as string)) { str_sNameTh = Request.QueryString["seNameTh"].ToString(); }
            if (!string.IsNullOrEmpty(Request.QueryString["seNameTax"] as string)) { str_sNameTax = Request.QueryString["seNameTax"].ToString(); }
        %>       
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Vendor Name En : </label></div>
                <div class="col-md-3"><input type="text" class="form-control" name="seNameEn" id="seNameEn" value="<%= str_sNameEn %>" /></div>
                <div class="col-md-7"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Vendor Name Th : </label></div>
                <div class="col-md-3"><input type="text" class="form-control" name="seNameTh" id="seNameTh" value="<%= str_sNameTh %>" /></div>
                <div class="col-md-7"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2"><label class="control-label">Tax ID : </label></div>
                <div class="col-md-3"><input type="text" class="form-control" name="seNameTax" id="seNameTax" value="<%= str_sNameTax %>" /></div>
                <div class="col-md-7"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ></div>
                <div class="col-md-3" style="text-align:left;"><input type="button" value="Search" class="btn btn-default" onclick="js_submitSearch('seNameEn', 'seNameTh', 'seNameTax', 'urlSubmit');" /> <input type="button" value="Clear" class="btn btn-default" onclick="js_clearSearch('urlSubmit');" /></div>
                <div class="col-md-7" style="text-align:left;"></div>
            </div>
        </div>
    </div>
</div>
<% if (!string.IsNullOrEmpty(Request.QueryString["seNameEn"] as string) || !string.IsNullOrEmpty(Request.QueryString["seNameTh"] as string) || !string.IsNullOrEmpty(Request.QueryString["seNameTax"] as string)){ %>
<div class="row">
    <div class="col-md-12">
    <table class="table table-bordered">
    <tr style="background-color:#9bbb59;">
        <td style="text-align:center;width:10%;">No.</td>
        <td style="text-align:center;width:35%;">Vendor Name (Eng)</td>
        <td style="text-align:center;width:35%;">Vendor Name (Thai)</td>
        <td style="text-align:center;width:20%;"></td>
    </tr>
    <%
        string detailColor = "", sql_seNameEn = "", sql_seNameTh = "", sql_seNameTax = "";
        int irows = 0;
        int icolor = 0;
        if (str_sNameEn != "") { sql_seNameEn = "and Vendor_Name_En like '%" + str_sNameEn + "%'"; }
        if (str_sNameTh != "") { sql_seNameTh = "and Vendor_Name_Th like '%" + str_sNameTh + "%'"; }
        if (str_sNameTax != "") { sql_seNameTax = "and Vendor_TaxID like '%" + str_sNameTax + "%'"; }
        string sql_vendorInfo = "select * from Vendor_Info where Vendor_TaxID != '' " + sql_seNameEn + " " + sql_seNameTh + " " + sql_seNameTax + " order by Vendor_Name_En asc";
        SqlCommand rs_vendorInfo = new SqlCommand(sql_vendorInfo, objConn);
        SqlDataReader obj_vendorInfo = rs_vendorInfo.ExecuteReader();
        while (obj_vendorInfo.Read())
        {
            irows++;
            icolor++;
            if (icolor == 1) { detailColor = "style=\"background-color:#ffffff;\""; } else { detailColor = "style=\"background-color:#f3f3f3;\""; icolor = 0; }
    %>
      <tr <%= detailColor %>>
        <td style="text-align:center;"><%= irows %></td>
        <td style="text-align:left;"><%= obj_vendorInfo["Vendor_Name_En"].ToString() %></td>
        <td style="text-align:left;"><%= obj_vendorInfo["Vendor_Name_Th"].ToString() %></td>
        <td style="text-align:center;"><input type="button" value="Vendor List" class="btn btn-default" <% Response.Write("onclick=\"js_venderForm('urlSubmit', '" + obj_vendorInfo["Vendor_TaxID"].ToString() + "', '" + obj_vendorInfo["VendorID"].ToString() + "');\""); %> /> </td>                   
      </tr>
     <% } obj_vendorInfo.Close(); %>
    </table>
    </div>
</div>
<% } %>
</div>

<div id="form_add" style="display:none;">
<script>
function vender_taxDuplicate() {
    var req = Inint_AJAX();
    var str = Math.random();
    var varUsername = document.getElementById('addNameTax').value;
    if (varUsername.length != 13)
    {
        document.getElementById('btnSubmit').disabled = true;
        document.getElementById('taxError').innerHTML = "<font color=\"red\">TAX ID must be 13 digit</font>";
        document.getElementById('taxError').style.display = "";
        document.getElementById('btnSubmitError').style.display = "none";
    } else {
        if (varUsername != '') {
            var str_url_address = "./pph_include/ajax/files/vender_taxDuplicate.aspx";
            var str_url = "var01=" + varUsername;
            str_url += "&clearmemory=" + str;
            req.open('POST', str_url_address, true)
            req.onreadystatechange = function () {
                if (req.readyState == 4) {
                    if (req.status == 200) {
                        var strRes = req.responseText;
                        if (strRes > "0") {
                            document.getElementById('btnSubmit').disabled = true;
                            document.getElementById('taxError').innerHTML = "<font color=\"red\">Duplicate TAX ID</font>";
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
    }
    }

function vender_nameEnDuplicate() {
    var req = Inint_AJAX();
    var str = Math.random();
    var varUsername = document.getElementById('addNameEn').value;
    if (varUsername != '') {
        var str_url_address = "./pph_include/ajax/files/vender_nameEnDuplicate.aspx";
        var str_url = "var01=" + varUsername;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    var strRes = req.responseText;
                    if (strRes > "0") {
                        document.getElementById('btnSubmit').disabled = true;
                        document.getElementById('nameEnError').innerHTML = "<font color=\"red\">Duplicate Vendor Name En.</font>";
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
}

function vender_nameThDuplicate() {
    var req = Inint_AJAX();
    var str = Math.random();
    var varUsername = document.getElementById('addNameTh').value;
    if (varUsername != '') {
        var str_url_address = "./pph_include/ajax/files/vender_nameThDuplicate.aspx";
        var str_url = "var01=" + varUsername;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    var strRes = req.responseText;
                    if (strRes > "0") {
                        document.getElementById('btnSubmit').disabled = true;
                        document.getElementById('nameThError').innerHTML = "<font color=\"red\">Duplicate Vendor Name Th.</font>";
                        document.getElementById('nameThError').style.display = "";
                        document.getElementById('btnSubmitError').style.display = "none";
                    }
                    else {
                        document.getElementById('btnSubmit').disabled = false;
                        document.getElementById('nameThError').style.display = "none";
                        document.getElementById('btnSubmitError').style.display = "none";
                    }
                }
            }
        }
        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.send(str_url);
    }
}

function vender_Submit(varA, varB) {
    var req = Inint_AJAX();
    var str = Math.random();
    var strTax = document.getElementById('addNameTax').value;
    var strNameEn = document.getElementById('addNameEn').value;
    var strNameTh = document.getElementById('addNameTh').value;
    if (strTax != '' && strNameEn != '' && strTax.length == 13 && strNameTh != '') {
        var str_url_address = "./pph_include/ajax/files/vender_Submit.aspx";
        var str_url = "var01=" + strTax;
        str_url += "&var02=" + strNameEn;
        str_url += "&var03=" + strNameTh;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    document.getElementById('btnSubmit').disabled = false;
                   // document.getElementById('btnSubmitError').innerHTML = "<font color=\"red\">Submit Success</font>";
                    document.getElementById('btnSubmitError').style.display = "none";
                    document.getElementById('addNameTax').value = "";
                    document.getElementById('addNameEn').value = "";
                    document.getElementById('addNameTh').value = "";
                    alert('Save Success');
                    //window.location.href = './master_vender.aspx?r=' + varA + '&id=' + varB;

                }
            }
        }
        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.send(str_url);
    }
    else {
        document.getElementById('btnSubmit').disabled = true;
        document.getElementById('btnSubmitError').innerHTML = "";
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
    document.getElementById('nameThError').style.display = "none";
    document.getElementById('btnSubmitError').style.display = "none";
</script>
<div class="row">
    <div class="col-md-12">
        <h4>Master Data > Vender > Add</h4>
        <hr />   
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Tax ID : </label></div>
                <div class="col-md-3">
                    <input type="text" class="form-control" name="addNameTax" id="addNameTax" maxlength="13" onkeypress='return isNumberKey(event)'  onchange="vender_taxDuplicate();" />
                    <p class="text-danger" id="taxError" style="display:none;"></p>
                </div>
                <div class="col-md-7"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Vendor Name En : </label></div>
                <div class="col-md-5"><input type="text" class="form-control" name="addNameEn" id="addNameEn" onchange="vender_nameEnDuplicate();" style="width:100%;"/><p class="text-danger" id="nameEnError" style="display:none;"></p></div>               
                <div class="col-md-5"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Vendor Name Th : </label></div>
                <div class="col-md-5"><input type="text" class="form-control" name="addNameTh" id="addNameTh" onchange="vender_nameThDuplicate();" style="width:100%;"/><p class="text-danger" id="nameThError" style="display:none;"></p></div>
                <div class="col-md-5"></div>
            </div>
        </div>       
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ></div>
                <div class="col-md-3" style="text-align:left;"><input type="button" id="btnSubmit" value="Save" class="btn btn-default" <% Response.Write("onclick=\"vender_Submit('" + Request.QueryString["r"].ToString() + "', '" + Request.QueryString["id"].ToString() + "');\""); %> /><p class="text-danger" id="btnSubmitError" style="display:none;"></p></div>
                <div class="col-md-7" style="text-align:left;"></div>
            </div>
        </div>
    </div>
</div>
</div>


<% if (!string.IsNullOrEmpty(Request.QueryString["taxID"] as string)){ %>
<script>
    document.getElementById('form_view').style.display = 'none';
    document.getElementById('form_add').style.display = 'none';
    document.getElementById('form_button').style.display = 'none';
    document.getElementById('form_addUsername').style.display = 'none';
</script>


<div id="form_vendor">
<div class="row">
    <div class="col-md-2"><input type="button" value="Back" class="btn btn-default" onclick="window.history.back();" style="width:100%;" /></div>
    <div class="col-md-2"></div>
    <div class="col-md-8"></div>
</div>
<br />
<div class="row">
    <div class="form-horizontal">
    <h4>Master Data > Vender > Vendor List</h4>
    <hr />
    </div>
</div>
<div class="row">
    <div class="col-md-12">
    <table class="table table-bordered">
    <tr style="background-color:#9bbb59;">
        <td style="text-align:center;width:10%;">No.</td>
        <td style="text-align:center;width:40%;">Vendor code</td>
        <td style="text-align:center;width:40%;">Username</td>
        <td style="text-align:center;width:10%;"></td>
    </tr>
    <%
        string detailColor = "";
        int irows = 0;
        int icolor = 0;
        string sql_vendorInfo = "select B.VendorID, B.Vendor_Code,B.Vendor_UserName  from Vendor_Info A , Vendor_Group B where  A.VendorID = B.VendorID and A.VendorID='"+Request.QueryString["vnID"]+"' Order by B.Vendor_Code  asc";
        SqlCommand rs_vendorInfo = new SqlCommand(sql_vendorInfo, objConn);
        SqlDataReader obj_vendorInfo = rs_vendorInfo.ExecuteReader();
        while (obj_vendorInfo.Read())
        {
            irows++;
            icolor++;
            if (icolor == 1) { detailColor = "style=\"background-color:#ffffff;\""; } else { detailColor = "style=\"background-color:#f3f3f3;\""; icolor = 0; }
    %>
      <tr <%= detailColor %>>
        <td style="text-align:center;"><%= irows %></td>
        <td style="text-align:center;"><%= obj_vendorInfo["Vendor_Code"].ToString() %></td>
        <td style="text-align:center;"><%= obj_vendorInfo["Vendor_UserName"].ToString() %></td>
        <td style="text-align:center;"><input type="checkbox" name="selectV[]" id="selectV_<%= irows %>" value="<%= obj_vendorInfo["VendorID"].ToString() %>-<%= obj_vendorInfo["Vendor_Code"].ToString() %>" /></td>                   
      </tr>
     <% } obj_vendorInfo.Close(); %>
    </table>
    </div>
</div>
<script>
    function ajax_duVendorCode2() {

        var req = Inint_AJAX();
        var str = Math.random();
        var strValue = document.getElementById('addVendorCode').value;
        if (strValue == "") {
            document.getElementById('btnAddVendorCode').disabled = true;
            document.getElementById('addVendorCodeError').innerHTML = "<font color=\"red\">field is required</font>";
            document.getElementById('addVendorCodeError').style.display = "";
        } else {
            var str_url_address = "./pph_include/ajax/files/ajax_duVendorCode.aspx";
            var str_url = "var01=" + strValue;
            str_url += "&clearmemory=" + str;
            req.open('POST', str_url_address, true)
            req.onreadystatechange = function () {
                if (req.readyState == 4) {
                    if (req.status == 200) {
                        var strRes = req.responseText;
                        if (strRes > "0") {
                            document.getElementById('btnAddVendorCode').disabled = true;
                            document.getElementById('addVendorCodeError').innerHTML = "<font color=\"red\">Duplicate Vendor Code</font>";
                            document.getElementById('addVendorCodeError').style.display = "";
                        }
                        else {
                            document.getElementById('btnAddVendorCode').disabled = false;
                            document.getElementById('addVendorCodeError').style.display = "none";
                        }
                    }
                }
            }
            req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            req.send(str_url);
        }
    }
    function ajax_duVendorCode(objVNID) {
        var req = Inint_AJAX();
        var str = Math.random();
        var strValue = document.getElementById('addVendorCode').value;
        var strVNID = document.getElementById('vnID').value;
        if (strValue == "") {
            document.getElementById('btnAddVendorCode').disabled = true;
            document.getElementById('addVendorCodeError').innerHTML = "<font color=\"red\">field is required</font>";
            document.getElementById('addVendorCodeError').style.display = "";
        } else {
            var str_url_address = "./pph_include/ajax/files/ajax_duVendorCode.aspx";
            var str_url = "var01=" + strValue;
            str_url += "&clearmemory=" + str;
            req.open('POST', str_url_address, true)
            req.onreadystatechange = function () {
                if (req.readyState == 4) {
                    if (req.status == 200) {
                        var strRes = req.responseText;
                        if (strRes > "0") {
                            document.getElementById('btnAddVendorCode').disabled = true;
                            document.getElementById('addVendorCodeError').innerHTML = "<font color=\"red\">Duplicate Vendor Code</font>";
                            document.getElementById('addVendorCodeError').style.display = "";
                        }
                        else {
                           
                            document.getElementById('btnAddVendorCode').disabled = false;
                            document.getElementById('addVendorCodeError').style.display = "none";
                            ajax_addVendorCode(strValue, strVNID);
                        }
                    }
                }
            }
            req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            req.send(str_url);
        }
    }
    function ajax_addVendorCode(strValue, strVNID) {
        var req = Inint_AJAX();
        var str = Math.random();
        var str_url_address = "./pph_include/ajax/files/ajax_addVendorCode.aspx";
        var str_url = "var01=" + strValue;
        str_url += "&var02=" + strVNID;
        str_url += "&clearmemory=" + str;
        //alert(strVNID);
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    alert('Save Success');
                    window.location.reload();
                }
            }
        }
        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.send(str_url);
    }
</script>
<% if(PH_EncrptHelper.MD5Decryp(Request.Cookies["PH_RoleUserCookie"].Value) == "A1"){ %>
<div class="form-group">
<div class="row">
    <input type="hidden" name="vnID" id="vnID" value="<%= Request.QueryString["taxID"] %>" />
    <div class="col-md-2"></div>
    <div class="col-md-2"><label class="control-label">Vendor Code </label></div>
    <div class="col-md-3"><input type="text" class="form-control" name="addVendorCode" id="addVendorCode" onchange="ajax_duVendorCode2();"   style="width:100%;" /><p class="text-danger" id="addVendorCodeError" style="display:none;"></p></div>
    <div class="col-md-5"></div>
</div>
</div>
<div class="form-group">
<div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-2"></div>
    <div class="col-md-3"><input type="button" value="Add Vendor Code" class="btn btn-default" id="btnAddVendorCode" style="width:100%;" onclick="ajax_duVendorCode('vnID');" /></div>
    <div class="col-md-5"></div>
</div>
</div>
<div class="form-group">
<div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-2"></div>
    <div class="col-md-3"><input type="button" value="Add Username" class="btn btn-default" style="width:100%;" onclick="document.getElementById('form_view').style.display = 'none'; document.getElementById('form_add').style.display = 'none'; document.getElementById('form_button').style.display = 'none'; document.getElementById('form_vendor').style.display = 'none'; document.getElementById('form_addUsername').style.display = ''; "/></div>
    <div class="col-md-5"></div>
</div>
</div>
 <% } %>
</div>
<div id="form_addUsername" style="display:none;">
<div class="row">
    <div class="col-md-2"><input type="button" value="Back" class="btn btn-default" onclick="window.location.reload();" style="width:100%;" /></div>
    <div class="col-md-2"></div>
    <div class="col-md-8"></div>
</div>
<br />
<div class="row">
    <script>
        function ajax_vnContactPoint(objValue) {
            var req = Inint_AJAX();
            var str = Math.random();
            var strValue = document.getElementById(objValue).value;
            if (strValue == "") {
                document.getElementById('showCP').value = "";
            } else {
                var str_url_address = "./pph_include/ajax/files/ajax_vnContactPoint.aspx";
                var str_url = "var01=" + strValue;
                str_url += "&clearmemory=" + str;
                req.open('POST', str_url_address, true)
                req.onreadystatechange = function () {
                    if (req.readyState == 4) {
                        if (req.status == 200) {
                            document.getElementById('showCP').value = req.responseText;
                            document.getElementById('btnSubmitAddUsername').disabled = false;
                            document.getElementById('btnSubmitErrorUsername').innerHTML = "";
                            document.getElementById('btnSubmitErrorUsername').style.display = "none";
                        }
                    }
                }
                req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                req.send(str_url);
            }
        }

        function ajax_addVendorUsername() {
            var req = Inint_AJAX();
            var str = Math.random();
            var strValue = document.getElementById('vn_username').value;
            var IDUP = "";
            var IDCO = "";
            var checkbox = document.getElementsByName('selectV[]'); for (var i = 0; i < checkbox.length; i++) { if (checkbox[i].checked) { var res = checkbox[i].value.split("-"); IDUP = IDUP + "|" + res[0] + "|"; IDCO = IDCO + "|" + res[1] + "|"; } }
            //alert(IDUP);
            //alert(IDCO);
            if (strValue == "") {
                document.getElementById('btnSubmitAddUsername').disabled = true;
                document.getElementById('btnSubmitErrorUsername').innerHTML = "<font color=\"red\">field is required</font>";
                document.getElementById('btnSubmitErrorUsername').style.display = "";
            } else {
                var str_url_address = "./pph_include/ajax/files/ajax_addVendorUsername.aspx";
                var str_url = "var01=" + strValue;
                str_url += "&var02=" + IDUP;
                str_url += "&var03=" + IDCO;
                str_url += "&clearmemory=" + str;
                req.open('POST', str_url_address, true)
                req.onreadystatechange = function () {
                    if (req.readyState == 4) {
                        if (req.status == 200) {
                            //alert(req.responseText);
                            alert('Save Success');
                            window.location.reload();
                        }
                    }
                }
                req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                req.send(str_url);
            }
        }
    </script>
    <div class="form-horizontal">
    <h4>Master Data > Vender > Vendor List > ADD Username</h4>
    <hr />
    <div class="form-group">
        <div class="row">
            <div class="col-md-2" style="text-align:right;"><label class="control-label">Username : </label></div>
            <div class="col-md-3">
            <select name="vn_username" id="vn_username" onchange="ajax_vnContactPoint('vn_username');">
                <option value="">กรุณาเลือก Username</option>
            <%
                string sql_vnUsername = "select UserName, Contact_Person from User_Profile where RoleID ='VD' order by UserName asc";
                SqlCommand rs_vnUsername = new SqlCommand(sql_vnUsername, objConn);
                SqlDataReader obj_vnUsername = rs_vnUsername.ExecuteReader();
                while (obj_vnUsername.Read()){
            %>
                <option value="<%= obj_vnUsername["UserName"].ToString() %>"><%= obj_vnUsername["UserName"].ToString() %></option>
            <% }obj_vnUsername.Close(); %>
            </select>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2" style="text-align:right;"><label class="control-label">Contact Point : </label></div>
            <div class="col-md-3"><input type="text" class="form-control" name="showCP" id="showCP" disabled="disabled" /></div>
            <div class="col-md-7"></div>
        </div>
    </div>
        <div class="form-group">
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-3"><input type="button" id="btnSubmitAddUsername" value="Save" class="btn btn-default" <% Response.Write("onclick=\"ajax_addVendorUsername();\""); %> /><br /><p class="text-danger" id="btnSubmitErrorUsername" style="display:none;"></p></div>
            <div class="col-md-7"></div>
        </div>
    </div>
    </div>
</div>
</div>    
<% } %>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>
