<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="master_haulier.aspx.cs" Inherits="PrimaryHaul.WebUI.master_haulier" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
<script>
    function js_tab(varTab) {
        document.getElementById('form_view').style.display = 'none';
        document.getElementById('form_add').style.display = 'none';
        document.getElementById(varTab).style.display = '';
    }
    function js_haulierForm(varUrl, varTax) {
        strUrl = document.getElementById(varUrl).value;
        window.location.href = strUrl + '&taxhlID=' + varTax;
    }
</script>
<div id="form_button">
<div class="row">
    <div class="col-md-4"><% if(PH_EncrptHelper.MD5Decryp(Request.Cookies["PH_RoleUserCookie"].Value) == "A1"){ %><input type="button" value="Add" class="btn btn-default" onclick="js_tab('form_add');" />&nbsp;&nbsp;&nbsp;<%} %><input type="button" value="View Data" class="btn btn-default" onclick="js_tab('form_view');" /></div>
    <div class="col-md-8"></div>
</div>
<br />
</div>
<input type="hidden" name="urlSubmit" id="urlSubmit" value="<%= HttpContext.Current.Request.Url.AbsolutePath %>?r=<%= Request.QueryString["r"].ToString() %>&id=<%= Request.QueryString["id"].ToString() %>" />
<div id="form_view">
<div class="row">
    <div class="col-md-12">
        <h4>Master Data > Haulier</h4>
        <hr />
        <table class="table table-bordered">
        <tr style="background-color:#9bbb59;">
            <td style="text-align:center;width:10%;">No.</td>
            <td style="text-align:center;width:30%;">Haulier ID</td>
            <td style="text-align:center;width:30%;">Haulier Name</td>
            <td style="text-align:center;width:20%;">Haulier</td>
            <td style="text-align:center;width:10%;"></td>
        </tr>
        <%
            string detailColor = "";
            int irows = 0;
            int icolor = 0;
            string sql_haulierInfo = "select * from Haulier_Info  order by Haulier_Name_En asc";
            SqlCommand rs_haulierInfo = new SqlCommand(sql_haulierInfo, objConn);
            SqlDataReader obj_haulierInfo = rs_haulierInfo.ExecuteReader();
            while (obj_haulierInfo.Read())
            {
                irows++;
                icolor++;
                if (icolor == 1) { detailColor = "style=\"background-color:#ffffff;\""; } else { detailColor = "style=\"background-color:#f3f3f3;\""; icolor = 0; }
        %>
          <tr <%= detailColor %>>
            <td style="text-align:center;"><%= irows %></td>
            <td style="text-align:center;"><%= obj_haulierInfo["Haulier_TaxID"].ToString() %></td>
            <td style="text-align:left;"><%= obj_haulierInfo["Haulier_Name_En"].ToString() %></td>
            <td style="text-align:center;"><%= obj_haulierInfo["Haulier_Abbr"].ToString() %></td>
            <td style="text-align:center;"><% if(PH_EncrptHelper.MD5Decryp(Request.Cookies["PH_RoleUserCookie"].Value) == "A1"){ %><input type="button" value="Edit" class="btn btn-default" <% Response.Write("onclick=\"js_haulierForm('urlSubmit', '" + obj_haulierInfo["Haulier_TaxID"].ToString() + "');\""); %> /> <%} %></td>                   
          </tr>
         <% } obj_haulierInfo.Close(); %>
        </table>
        </div>
    </div>
</div>

<div id="form_add" style="display:none;">
<script>
    function haulier_taxDuplicate() {
        var req = Inint_AJAX();
        var str = Math.random();
        var strTax = document.getElementById('Haulier_TaxID').value;
        if (strTax.length < 9) {
            document.getElementById('btnSubmit').disabled = true;
            document.getElementById('taxError').innerHTML = "<font color=\"red\">TaxID ต้องมี 13 Digit</font>";
            document.getElementById('taxError').style.display = "";
            document.getElementById('btnSubmitError').style.display = "none";
        }
        else {
            var str_url_address = "./pph_include/ajax/files/haulier_taxDuplicate.aspx";
            var str_url = "var01=" + strTax;
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

    function haulier_nameEnDuplicate() {
        var req = Inint_AJAX();
        var str = Math.random();
        var strNameEn = document.getElementById('Haulier_Name_En').value;
        var str_url_address = "./pph_include/ajax/files/haulier_nameEnDuplicate.aspx";
        var str_url = "var01=" + strNameEn;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    var strRes = req.responseText;
                    if (strRes > "0") {
                        document.getElementById('btnSubmit').disabled = true;
                        document.getElementById('nameEnError').innerHTML = "<font color=\"red\">Duplicate Haulier Name</font>";
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

    function haulier_abbrDuplicate() {
        var req = Inint_AJAX();
        var str = Math.random();
        var strAbbr = document.getElementById('Haulier_Abbr').value;
        var str_url_address = "./pph_include/ajax/files/haulier_abbrDuplicate.aspx";
        var str_url = "var01=" + strAbbr;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    var strRes = req.responseText;
                    if (strRes > "0") {
                        document.getElementById('btnSubmit').disabled = true;
                        document.getElementById('abbrError').innerHTML = "<font color=\"red\">Duplicate Haulier Abbr</font>";
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

    function haulier_Submit() {
        var req = Inint_AJAX();
        var str = Math.random();
        var strTax = document.getElementById('Haulier_TaxID').value;
        var strName = document.getElementById('Haulier_Name_En').value;
        var strAbbr = document.getElementById('Haulier_Abbr').value;
        if (strTax != '' && strName != '' && strAbbr != '' && strTax != 13) {
            var str_url_address = "./pph_include/ajax/files/haulier_Submit.aspx";
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
                        document.getElementById('Haulier_TaxID').value = "";
                        document.getElementById('Haulier_Name_En').value = "";
                        document.getElementById('Haulier_Abbr').value = "";
                        alert('Save Success');
                        window.location.reload();
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
    document.getElementById('abbrError').style.display = "none";
    document.getElementById('btnSubmitError').style.display = "none";
</script>
<div class="row">
    <div class="col-md-12">
        <h4>Master Data > Haulier > Add</h4>
        <hr />   
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Tax ID </label></div>
                <div class="col-md-3">
                    <input type="text" class="form-control" name="Haulier_TaxID" id="Haulier_TaxID" onkeypress='return isNumberKey(event)' maxlength="13"  onchange="haulier_taxDuplicate();" />
                    <p class="text-danger" id="taxError" style="display:none;"></p>
                </div>
                <div class="col-md-7"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Haulier Name </label></div>
                <div class="col-md-5"><input type="text" class="form-control" name="Haulier_Name_En" id="Haulier_Name_En" onchange="haulier_nameEnDuplicate();" style="width:100%;"/><p class="text-danger" id="nameEnError" style="display:none;"></p></div>               
                <div class="col-md-5"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Haulier Abbr </label></div>
                <div class="col-md-5"><input type="text" class="form-control" name="Haulier_Abbr" id="Haulier_Abbr" onchange="haulier_abbrDuplicate();" style="width:100%;"/><p class="text-danger" id="abbrError" style="display:none;"></p></div>
                <div class="col-md-5"></div>
            </div>
        </div>       
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" style="text-align:right;"></div>
                <div class="col-md-3" style="text-align:left;"><input type="button" id="btnSubmit" value="Save" class="btn btn-default" onclick="haulier_Submit();" /><p class="text-danger" id="btnSubmitError" style="display:none;"></p></div>
                <div class="col-md-7" style="text-align:left;"></div>
            </div>
        </div>
    </div>
</div>
</div>

<% if (!string.IsNullOrEmpty(Request.QueryString["taxhlID"] as string)){ %>
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
<div id="form_vendor">
<script>

    function haulier_edit_nameEnDuplicate() {
        var req = Inint_AJAX();
        var str = Math.random();
        var strNameEn = document.getElementById('edit_Haulier_Name_En').value;
        var str_url_address = "./pph_include/ajax/files/haulier_nameEnDuplicate.aspx";
        var str_url = "var01=" + strNameEn;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    var strRes = req.responseText;
                    if (strRes > "0") {
                        document.getElementById('edit_btnSubmit').disabled = true;
                        document.getElementById('edit_nameEnError').innerHTML = "<font color=\"red\">Duplicate Haulier Name</font>";
                        document.getElementById('edit_nameEnError').style.display = "";
                        document.getElementById('edit_btnSubmitError').style.display = "none";
                    }
                    else {
                        document.getElementById('edit_btnSubmit').disabled = false;
                        document.getElementById('edit_nameEnError').style.display = "none";
                        document.getElementById('edit_btnSubmitError').style.display = "none";
                    }
                }
            }
        }
        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.send(str_url);
    }

    function haulier_edit_abbrDuplicate() {
        var req = Inint_AJAX();
        var str = Math.random();
        var strAbbr = document.getElementById('edit_Haulier_Abbr').value;
        var str_url_address = "./pph_include/ajax/files/haulier_abbrDuplicate.aspx";
        var str_url = "var01=" + strAbbr;
        str_url += "&clearmemory=" + str;
        req.open('POST', str_url_address, true)
        req.onreadystatechange = function () {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    var strRes = req.responseText;
                    if (strRes > "0") {
                        document.getElementById('edit_btnSubmit').disabled = true;
                        document.getElementById('edit_abbrError').innerHTML = "<font color=\"red\">Duplicate Haulier Abbr</font>";
                        document.getElementById('edit_abbrError').style.display = "";
                        document.getElementById('edit_btnSubmitError').style.display = "none";
                    }
                    else {
                        document.getElementById('edit_btnSubmit').disabled = false;
                        document.getElementById('edit_abbrError').style.display = "none";
                        document.getElementById('edit_btnSubmitError').style.display = "none";
                    }
                }
            }
        }
        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.send(str_url);
    }

    function haulier_edit_Submit(varA, varB) {
        var req = Inint_AJAX();
        var str = Math.random();
        var strTax = document.getElementById('edit_Haulier_TaxID').value;
        var strName = document.getElementById('edit_Haulier_Name_En').value;
        var strAbbr = document.getElementById('edit_Haulier_Abbr').value;
        if (strTax != '' && strName != '' && strAbbr != '') {
            var str_url_address = "./pph_include/ajax/files/haulier_edit_Submit.aspx";
            var str_url = "var01=" + strTax;
            str_url += "&var02=" + strName;
            str_url += "&var03=" + strAbbr;
            str_url += "&clearmemory=" + str;
            req.open('POST', str_url_address, true)
            req.onreadystatechange = function () {
                if (req.readyState == 4) {
                    if (req.status == 200) {
                        document.getElementById('edit_btnSubmit').disabled = false;
                        //document.getElementById('edit_btnSubmitError').innerHTML = "<font color=\"red\">Save Success</font>";
                        document.getElementById('edit_btnSubmitError').style.display = "none";
                        document.getElementById('edit_Haulier_TaxID').value = "";
                        document.getElementById('edit_Haulier_Name_En').value = "";
                        document.getElementById('edit_Haulier_Abbr').value = "";
                        alert('Save Success');
                        window.location.href = './master_haulier.aspx?r='+varA+'&id='+varB;
                    }
                }
            }
            req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            req.send(str_url);
        }
        else {
            document.getElementById('edit_btnSubmit').disabled = true;
            document.getElementById('edit_btnSubmitError').innerHTML = "<font color=\"red\">field is required</font>";
            document.getElementById('edit_btnSubmitError').style.display = "";
        }
    }
    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        return true;
    }
    document.getElementById('edit_nameEnError').style.display = "none";
    document.getElementById('edit_abbrError').style.display = "none";
    document.getElementById('edit_btnSubmitError').style.display = "none";
</script>
<div class="row">
    <% 
       string sql_haulier = "select Haulier_TaxID, Haulier_Name_En, Haulier_Abbr from Haulier_Info  where Haulier_TaxID ='" + Request.QueryString["taxhlID"] + "'";
       SqlCommand rs_haulier = new SqlCommand(sql_haulier, objConn);
       SqlDataReader obj_haulier = rs_haulier.ExecuteReader();
       obj_haulier.Read();           
    %>
    <div class="col-md-12">
        <h4>Master Data > Haulier > Edit</h4>
        <hr />   
        <div class="form-group">
            <div class="row">
                <div class="col-md-2"><label class="control-label">Tax ID </label></div>
                <div class="col-md-3">
                    <input type="text" value="<%= obj_haulier[0].ToString() %>" class="form-control" disabled="disabled" />
                    <input type="hidden" class="form-control" name="edit_Haulier_TaxID" id="edit_Haulier_TaxID" value="<%= obj_haulier[0].ToString() %>" />
                </div>
                <div class="col-md-7"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Haulier Name </label></div>
                <div class="col-md-5"><input type="text" value="<%= obj_haulier[1].ToString() %>" class="form-control" name="edit_Haulier_Name_En" id="edit_Haulier_Name_En" onchange="haulier_edit_nameEnDuplicate();" style="width:100%;"/><p class="text-danger" id="edit_nameEnError" style="display:none;"></p></div>               
                <div class="col-md-5"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Haulier Abbr </label></div>
                <div class="col-md-5"><input type="text" value="<%= obj_haulier[2].ToString() %>" class="form-control" name="edit_Haulier_Abbr" id="edit_Haulier_Abbr" onchange="haulier_edit_abbrDuplicate();" style="width:100%;"/><p class="text-danger" id="edit_abbrError" style="display:none;"></p></div>
                <div class="col-md-5"></div>
            </div>
        </div>       
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" style="text-align:right;"></div>
                <div class="col-md-3" style="text-align:left;"><input type="button" id="edit_btnSubmit" value="Save" class="btn btn-default" <% Response.Write("onclick=\"haulier_edit_Submit('" + Request.QueryString["r"].ToString() + "', '" + Request.QueryString["id"].ToString() + "');\""); %>  /><p class="text-danger" id="edit_btnSubmitError" style="display:none;"></p></div>
                <div class="col-md-7" style="text-align:left;"></div>
            </div>
        </div>
    </div>
    <% obj_haulier.Close(); %>
</div>
</div>
<% } %>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>
