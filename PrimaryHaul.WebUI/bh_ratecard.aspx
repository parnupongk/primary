<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="bh_ratecard.aspx.cs" Inherits="PrimaryHaul.WebUI.bh_ratecard" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
<% string strFrm = "form_import"; if (!string.IsNullOrEmpty(Request.QueryString["frm"] as string)) { strFrm = Request.QueryString["frm"].ToString(); }  %>
<input type="hidden" name="urlSubmit" id="urlSubmit" value="<%= HttpContext.Current.Request.Url.AbsolutePath %>?r=<%= Request.QueryString["r"].ToString() %>&id=<%= Request.QueryString["id"].ToString() %>" />
<script>
    function js_tab(varTab) {
        document.getElementById('form_view').style.display = 'none';
        document.getElementById('form_import').style.display = 'none';
        document.getElementById(varTab).style.display = '';
    }
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />
<div class="form-horizontal">

    <div id="form_button">
        <div class="row">
            <div class="col-md-4">
                <input type="button" value="Import File" class="btn btn-default" onclick="js_tab('form_import');" />&nbsp;&nbsp;&nbsp;
                <input type="button" value="View Data" class="btn btn-default" onclick="js_tab('form_view');" />
            </div>
            <div class="col-md-8"></div>
        </div>
    </div>

    <div id="form_import" style="display:none;">
        <div class="col-md-12">
            <h4>Master > Backhaul Rate Card‏ > Import File</h4>
            <hr /> 
            <div runat="server" class="form-group">
                <asp:Label runat="server" AssociatedControlID="lnkFile" CssClass="col-md-3 control-label"></asp:Label>
                <div class="col-md-9"><a runat="server" id="lnkFile" href="file/bh_ratecard.xlsx" target="_blank" >file ตัวอย่าง</a></div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="AjaxFileUpload" CssClass="col-md-3 control-label">Import File :</asp:Label>
                <div class="col-md-9"><asp:AjaxFileUpload ID="AjaxFileUpload" runat="server" Padding-Bottom="4" Padding-Left="2" Padding-Right="1" Padding-Top="4" ThrobberID="myThrobber" MaximumNumberOfFiles="10" AllowedFileTypes="xls,vnd.ms-excel,xls,jpg,png,application/vnd.ms-excel,xlsx" OnUploadComplete="AjaxFileUpload_UploadComplete" /></div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-3 col-md-9"><asp:Label ID="msgInsert" runat="server"></asp:Label></div>
            </div> 
            <div class="form-group">
                <div class="col-md-offset-3 col-md-9">
                    <asp:Button runat="server" ID="btnSubmit" Text="Submit" CssClass="btn btn-default" OnClick="btnSubmit_Click" /><p class="text-danger"><asp:Label ID="lblErr" runat="server"></asp:Label></p>
                </div>
            </div> 
        </div>
    </div>

    <div id="form_view" style="display:none;">
        <script>
            function js_BHRatecard_Search(varUrl, varVendor){
                window.location.href = document.getElementById(varUrl).value + '&frm=form_view&vendor=' + document.getElementById(varVendor).value;
            }
            function js_BHRatecard_Edit(varHid, varBtn, varDivStart, varDivEnd, varSave) {
                if (document.getElementById(varHid).value == 'off') {
                    document.getElementById(varHid).value = 'on';
                    document.getElementById(varBtn).value = 'Cancel';
                    document.getElementById(varDivStart).style.display = '';
                    document.getElementById(varDivEnd).style.display = '';
                    document.getElementById(varSave).style.display = '';
                }
                else {
                    document.getElementById(varHid).value = 'off';
                    document.getElementById(varBtn).value = 'Edit';
                    document.getElementById(varDivStart).style.display = 'none';
                    document.getElementById(varDivEnd).style.display = 'none';
                    document.getElementById(varSave).style.display = 'none';
                }
            }
            function js_BHRatecard_Save(varID, varStart, varEnd, lbStart, lbEnd, varHid, varBtn, varDivStart, varDivEnd, varSave) {
                var r = confirm("Press OK For Save");
                if (r == true) {
                    var req = Inint_AJAX();
                    var str = Math.random();
                    var str_url_address = "./pph_include/ajax/files/ajax_BHratecard.aspx";
                    var str_url = "var01=" + varID;
                    str_url += "&var02=" + document.getElementById(varStart).value;
                    str_url += "&var03=" + document.getElementById(varEnd).value;
                    str_url += "&varDP=2";
                    str_url += "&clearmemory=" + str;
                    req.open('POST', str_url_address, true)
                    req.onreadystatechange = function () {
                        if (req.readyState == 4) {
                            if (req.status == 200) {
                                if (req.responseText == "1") {
                                    alert("Save Success");
                                    document.getElementById(lbStart).innerHTML = document.getElementById(varStart).value;
                                    document.getElementById(lbEnd).innerHTML = document.getElementById(varEnd).value;
                                    document.getElementById(varHid).value = 'on';
                                    js_BHRatecard_Edit(varHid, varBtn, varDivStart, varDivEnd, varSave);
                                } else {
                                    alert("Save was not successfully");
                                }
                            }
                        }
                    }
                    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    req.send(str_url);
                }
            }
        </script>
        <% string detailColor = "", strVendor = ""; if (!string.IsNullOrEmpty(Request.QueryString["vendor"] as string)) { strVendor = Request.QueryString["vendor"].ToString(); } %>
        <div class="row">
            <div class="col-md-12">
                <h4>Master > Backhaul Rate Card</h4>
                <hr />
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">             
                <div class="row">
                    <div class="col-md-1"><label class="control-label">Vendor : </label></div>
                    <div class="col-md-3" style="text-align:left;"><input type="text" class="form-control" name="vendor" id="vendor" value="<%= strVendor %>" style="width:100%;"/></div>
                    <div class="col-md-8" style="text-align:left;"><input type="button" value="Search" class="btn btn-default" onclick="js_BHRatecard_Search('urlSubmit', 'vendor');" /></div>
                </div>
                <div class="row">
                    <div class="col-md-12" ><br /></div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-bordered">
                    <tr style="background-color:#9bbb59;">
                        <td style="text-align:center;width:5%;">No.</td>
                        <td style="text-align:center;width:10%;">Vendor Code</td>
                        <td style="text-align:center;width:20%;">Vendor Name</td>
                        <td style="text-align:center;width:5%;">DC</td>
                        <td style="text-align:center;width:10%;">Charge Type</td>
                        <td style="text-align:center;width:5%;">Rate</td>
                        <td style="text-align:center;width:9%;">Unloading cost<br />(Bath/Load)</td>
                        <td style="text-align:center;width:9%;">Income Type</td>
                        <td style="text-align:center;width:9%;">Start Date</td>
                        <td style="text-align:center;width:9%;">End Date</td>
                        <td style="text-align:center;width:9%;"></td>
                    </tr>
                    <%
                        int irows = 0, icolor = 0;
                        SqlDataReader bh_ratecard = PPH_SC.PPH_BH.get_bh_ratecard(System.Configuration.ConfigurationManager.AppSettings["ConnectionString"], strVendor);
                        if (bh_ratecard.HasRows) { 
                            while (bh_ratecard.Read()){
                                irows++;icolor++;
                                if (icolor == 1) { detailColor = "style=\"background-color:#ffffff;\""; } else { detailColor = "style=\"background-color:#f3f3f3;\""; icolor = 0; }
                    %>
                    <tr <%= detailColor %>>
                        <td style="text-align:center;"><%= irows %></td>
                        <td style="text-align:center;"><%= bh_ratecard["Vendor_Code"].ToString() %></td>
                        <td style="text-align:center;"><%= bh_ratecard["Vendor_Name"].ToString() %></td> 
                        <td style="text-align:center;"><%= bh_ratecard["DC_No"].ToString() %></td>
                        <td style="text-align:center;"><%= bh_ratecard["ChargeType"].ToString() %></td> 
                        <td style="text-align:center;"><%= bh_ratecard["Rate"].ToString() %></td>        
                        <td style="text-align:center;"><%= bh_ratecard["Unloading_Cost"].ToString() %></td>
                        <td style="text-align:center;"><%= bh_ratecard["Income_Type"].ToString() %></td> 
                        <td style="text-align:center;">
                            <div id="label_startDate_<%= bh_ratecard["RateCard_ID"].ToString() %>"><%= bh_ratecard["str_StartDate"].ToString() %></div>
                            <div id="div_startDate_<%= bh_ratecard["RateCard_ID"].ToString() %>" style="display:none;"><input type="text" class="form-control" name="startDate_<%= bh_ratecard["RateCard_ID"].ToString() %>" id="startDate_<%= bh_ratecard["RateCard_ID"].ToString() %>" value="<%= bh_ratecard["str_StartDate"].ToString() %>" style="width:100%;padding:2px;text-align:center;"/></div>
                        </td> 
                        <td style="text-align:center;">
                            <div id="label_endDate_<%= bh_ratecard["RateCard_ID"].ToString() %>"><%= bh_ratecard["str_EndDate"].ToString() %></div>
                            <div id="div_endDate_<%= bh_ratecard["RateCard_ID"].ToString() %>" style="display:none;"><input type="text" class="form-control" name="endDate_<%= bh_ratecard["RateCard_ID"].ToString() %>" id="endDate_<%= bh_ratecard["RateCard_ID"].ToString() %>" value="<%= bh_ratecard["str_EndDate"].ToString() %>" style="width:100%;padding:2px;text-align:center;"/></div>
                        </td> 
                        <td style="text-align:center;">
                            <input type="hidden" name="hid_edit_<%= bh_ratecard["RateCard_ID"].ToString() %>" id="hid_edit_<%= bh_ratecard["RateCard_ID"].ToString() %>" value="off" />
                            <input type="button" value="Edit" class="btn btn-default" style="width:100%;" id="btn_edit_<%= bh_ratecard["RateCard_ID"].ToString() %>" <% Response.Write("onclick=\"js_BHRatecard_Edit('hid_edit_" + bh_ratecard["RateCard_ID"].ToString() + "', 'btn_edit_" + bh_ratecard["RateCard_ID"].ToString() + "', 'div_startDate_" + bh_ratecard["RateCard_ID"].ToString() + "', 'div_endDate_" + bh_ratecard["RateCard_ID"].ToString() + "', 'div_save_" + bh_ratecard["RateCard_ID"].ToString() + "');\""); %> /> 
                            <div id="div_save_<%= bh_ratecard["RateCard_ID"].ToString() %>" style="padding-top:5px;display:none;"><input type="button" value="Save" style="width:100%;" class="btn btn-warning" <% Response.Write("onclick=\"js_BHRatecard_Save('" + bh_ratecard["RateCard_ID"].ToString() + "', 'startDate_" + bh_ratecard["RateCard_ID"].ToString() + "', 'endDate_" + bh_ratecard["RateCard_ID"].ToString() + "', 'label_startDate_" + bh_ratecard["RateCard_ID"].ToString() + "', 'label_endDate_" + bh_ratecard["RateCard_ID"].ToString() + "','hid_edit_" + bh_ratecard["RateCard_ID"].ToString() + "', 'btn_edit_" + bh_ratecard["RateCard_ID"].ToString() + "', 'div_startDate_" + bh_ratecard["RateCard_ID"].ToString() + "', 'div_endDate_" + bh_ratecard["RateCard_ID"].ToString() + "', 'div_save_" + bh_ratecard["RateCard_ID"].ToString() + "');\""); %> /></div>
                            <% Response.Write("<script>$(function () {$(\"#startDate_" + bh_ratecard["RateCard_ID"].ToString() + "\").datepicker({ dateFormat: 'dd/mm/yy' });$(\"#endDate_" + bh_ratecard["RateCard_ID"].ToString() + "\").datepicker({ dateFormat: 'dd/mm/yy', minDate: 0 });});</script>");%>
                        </td>                 
                    </tr>
                    <% } bh_ratecard.Close(); } %>
                </table>
            </div>
        </div>       
    </div>

</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="./pph_include/jquery/jquery-ui.js"></script>
<style>div.ui-datepicker{font-size:14px;}</style> 
<% Response.Write("<script>js_tab('" + strFrm + "')</script>"); %>
</asp:Content>
