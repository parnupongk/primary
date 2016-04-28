<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="master_vendor_edit.aspx.cs" Inherits="PrimaryHaul.WebUI.master_vendor_edit" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
<div id="form_button">
<div class="row">
    <div class="col-md-2"><input type="button" value="Back" class="btn btn-default" onclick="window.history.back();" style="width:100%;" /></div>
    <div class="col-md-8"></div>
</div>
<br />
</div>
<input type="hidden" name="r" id="r" value="<%= Request.QueryString["r"].ToString() %>" />
<script>
    function vender_taxDuplicate() {
        var req = Inint_AJAX();
        var str = Math.random();
        var varUsername = document.getElementById('addNameTax').value;
        var strRole = document.getElementById('r').value;
        if (varUsername.length != 13) {
            document.getElementById('btnSubmit').disabled = true;
            document.getElementById('taxError').innerHTML = "<font color=\"red\">TAX ID must be 13 digit</font>";
            document.getElementById('taxError').style.display = "";
            document.getElementById('btnSubmitError').style.display = "none";
        } else {
            if (varUsername != '') {
                var str_url_address = "./pph_include/ajax/files/vender_taxDuplicate.aspx";
                var str_url = "var01=" + varUsername;
                str_url += "&var02=" + strRole;
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
        var strRole = document.getElementById('r').value;
        if (varUsername != '') {
            var str_url_address = "./pph_include/ajax/files/vender_nameEnDuplicate.aspx";
            var str_url = "var01=" + varUsername;
            str_url += "&var02=" + strRole;
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
        var strRole = document.getElementById('r').value;
        if (varUsername != '') {
            var str_url_address = "./pph_include/ajax/files/vender_nameThDuplicate.aspx";
            var str_url = "var01=" + varUsername;
            str_url += "&var02=" + strRole;
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

    function vender_Submit(varA, varB, varC, varD, varE) {
        var req = Inint_AJAX();
        var str = Math.random();
        var strTax = document.getElementById('addNameTax').value;
        var strNameEn = document.getElementById('addNameEn').value;
        var strNameTh = document.getElementById('addNameTh').value;
        if (strTax != '' && strNameEn != '' && strTax.length == 13) {
            var str_url_address = "./pph_include/ajax/files/vender_edit_submit.aspx";
            var str_url = "var01=" + strTax;
            str_url += "&var02=" + strNameEn;
            str_url += "&var03=" + strNameTh;
            str_url += "&var04=" + varC;
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
                        window.location.href = './master_vender.aspx?r=' + varA + '&id=' + varB + '&seName=' + varD + '&seCode=' + varE;
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
 <% 
     string sql_vendor = "select * from Vendor_Info   where VendorID ='" + Request.QueryString["vdID"] + "'";
    SqlCommand rs_vendor = new SqlCommand(sql_vendor, objConn);
    SqlDataReader obj_vendor = rs_vendor.ExecuteReader();
    obj_vendor.Read();           
%>
<div class="row">
    <div class="col-md-12">
        <h4>Master Data > Vender > Edit</h4>
        <hr />   
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Tax ID : </label></div>
                <div class="col-md-3">
                    <input type="text" class="form-control" name="addNameTax" id="addNameTax" maxlength="13" onkeypress='return isNumberKey(event)'  onchange="vender_taxDuplicate();" value="<%= obj_vendor["Vendor_TaxID"].ToString() %>" />
                    <p class="text-danger" id="taxError" style="display:none;"></p>
                </div>
                <div class="col-md-7"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Vendor Name En : </label></div>
                <div class="col-md-5"><input type="text" class="form-control" name="addNameEn" id="addNameEn" onchange="vender_nameEnDuplicate();" style="width:100%;" value="<%= obj_vendor["Vendor_Name_En"].ToString() %>"/><p class="text-danger" id="nameEnError" style="display:none;"></p></div>               
                <div class="col-md-5"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ><label class="control-label">Vendor Name Th : </label></div>
                <div class="col-md-5"><input type="text" class="form-control" name="addNameTh" id="addNameTh" onchange="vender_nameThDuplicate();" style="width:100%;" value="<%= obj_vendor["Vendor_Name_Th"].ToString() %>"/><p class="text-danger" id="nameThError" style="display:none;"></p></div>
                <div class="col-md-5"></div>
            </div>
        </div>       
        <div class="form-group">
            <div class="row">
                <div class="col-md-2" ></div>
                <div class="col-md-3" style="text-align:left;"><input type="button" id="btnSubmit" value="Save" class="btn btn-default" <% Response.Write("onclick=\"vender_Submit('" + Request.QueryString["r"].ToString() + "', '" + Request.QueryString["id"].ToString() + "', '" + Request.QueryString["vdID"].ToString() + "', '" + Request.QueryString["seName"].ToString() + "', '" + Request.QueryString["seCode"].ToString() + "');\""); %> /><p class="text-danger" id="btnSubmitError" style="display:none;"></p></div>
                <div class="col-md-7" style="text-align:left;"></div>
            </div>
        </div>
    </div>
</div>
</asp:Content>
