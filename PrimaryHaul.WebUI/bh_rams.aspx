<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="bh_rams.aspx.cs" Inherits="PrimaryHaul.WebUI.bh_rams" %>
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
    function js_reload(varUrl) {
        window.location.href = document.getElementById(varUrl).value
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
    <script>
        function js_perload()
        {
            document.getElementById('msgPerload').innerHTML = "<p style=\"color:#000088; font-weight:bold;\">please wait a few minutes <img src=\"./pph_include/images/loading.gif\" style=\"width:25px;\"></p>";
        }
    </script>
    <div id="form_import" style="display:none;">
        <div class="row">
            <div class="col-md-12">
                <h4>Master > Backhaul RAMS‏ > Import File</h4>
                <hr /> 
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">             
                <div class="row">
                    <div class="col-md-offset-2 col-md-1"><label class="control-label">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Week : </label></div>
                    <div class="col-md-9" style="text-align:left;"><label class="control-label"><%= str_yw %></label><input type="hidden" name="hidYW" id="hidYW" runat="server" /></div>
                </div>
                <div class="row">
                    <div class="col-md-12" ><br /></div>
                </div>
            </div>
         </div>
        <div class="row">
            <div class="col-md-12">             
                <div runat="server" class="form-group">
                    <asp:Label runat="server" AssociatedControlID="lnkFile" CssClass="col-md-3 control-label"></asp:Label>
                    <div class="col-md-9"><a runat="server" id="lnkFile" href="file/Ex_BH_RAMS_WKxx.xlsx" target="_blank" >file ตัวอย่าง</a></div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="AjaxFileUpload" CssClass="col-md-3 control-label">Import File :</asp:Label>
                    <div class="col-md-9"><asp:AjaxFileUpload ID="AjaxFileUpload" runat="server" Padding-Bottom="4" Padding-Left="2" Padding-Right="1" Padding-Top="4" ThrobberID="myThrobber" MaximumNumberOfFiles="10" AllowedFileTypes="xls,vnd.ms-excel,xls,jpg,png,application/vnd.ms-excel,xlsx,xlsb" OnUploadComplete="AjaxFileUpload_UploadComplete" /></div>
                </div>
                <div class="form-group">
                    <div class="col-md-offset-3 col-md-9"><span id="msgPerload"></span><asp:Label ID="msgInsert" runat="server"></asp:Label></div>
                </div> 
                <div class="form-group">
                    <div class="col-md-offset-3 col-md-9">
                        <asp:Button runat="server" ID="btnSubmit" Text="Submit" CssClass="btn btn-default" OnClick="btnSubmit_Click"  OnClientClick="js_perload()" /><p class="text-danger"><asp:Label ID="lblErr" runat="server"></asp:Label></p>
                    </div>
                    <div class="col-md-offset-3 col-md-9">
                        <button type="button" onclick="js_reload('urlSubmit');" class="btn btn-default">Reload File</button>
                    </div>
                </div> 
            </div>
        </div>
    </div>

    <div id="form_view" style="display:none;">
        <script>
            function js_BHrams_Search(varUrl, varWeek, varVendor) {
                window.location.href = document.getElementById(varUrl).value + '&frm=form_view&week=' + document.getElementById(varWeek).value + '&vendor=' + document.getElementById(varVendor).value;
            }
            function js_BHrams_Delete(varURL, varWeek) {
                var r = confirm("Press OK For Delete (Week : " + document.getElementById(varWeek).value+")");
                if (r == true) {
                    document.getElementById('msg_process').innerHTML = '<p style=\"color:#000088; font-weight:bold;\">please wait a few minutes <img src=\"./pph_include/images/loading.gif\" style=\"width:25px;\"></p>';
                    var req = Inint_AJAX();
                    var str = Math.random();
                    var str_url_address = "./pph_include/ajax/files/ajax_BHrams.aspx";
                    var str_url = "var01=" + document.getElementById(varWeek).value;
                    str_url += "&varDP=3";
                    str_url += "&clearmemory=" + str;
                    req.open('POST', str_url_address, true)
                    req.onreadystatechange = function () {
                        if (req.readyState == 4) {
                            if (req.status == 200) {
                                if (req.responseText == "1") {
                                    alert("Delete Success");
                                } else {
                                    alert("Delete was not successfully");
                                }
                                document.getElementById('msg_process').innerHTML = "&nbsp;";
                            }
                        }
                    }
                    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    req.send(str_url);
                }
            }
            function js_BHrams_rollback(varURL, varWeek) {
                var r = confirm("Press OK For Rollback (Week : " + document.getElementById(varWeek).value + ")");
                if (r == true) {
                    document.getElementById('msg_process').innerHTML = '<p style=\"color:#000088; font-weight:bold;\">please wait a few minutes <img src=\"./pph_include/images/loading.gif\" style=\"width:25px;\"></p>';
                    var req = Inint_AJAX();
                    var str = Math.random();
                    var str_url_address = "./pph_include/ajax/files/ajax_BHrams.aspx";
                    var str_url = "var01=" + document.getElementById(varWeek).value;
                    str_url += "&varDP=4";
                    str_url += "&clearmemory=" + str;
                    req.open('POST', str_url_address, true)
                    req.onreadystatechange = function () {
                        if (req.readyState == 4) {
                            if (req.status == 200) {
                                if (req.responseText == "1") {
                                    alert("Rollback Success");
                                } else {
                                    alert("Rollback was not successfully");
                                }
                                document.getElementById('msg_process').innerHTML = "&nbsp;";
                            }
                        }
                    }
                    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    req.send(str_url);
                }
            }
        </script>
        <% string detailColor = "", strVendor = "", strWeek = ""; if (!string.IsNullOrEmpty(Request.QueryString["vendor"] as string)) { strVendor = Request.QueryString["vendor"].ToString(); } if (!string.IsNullOrEmpty(Request.QueryString["week"] as string)) { strWeek = Request.QueryString["week"].ToString(); } %>
        <div class="row">
            <div class="col-md-12">
                <h4>Master > Backhaul RAMS</h4>
                <hr />
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">  
                <div class="row">
                    <div class="col-md-1"><label class="control-label">Week : </label></div>
                    <div class="col-md-3" style="text-align:left;">
                        <select class="form-control" style="width:100%;" id="week" name="week">
                            <%
                                SqlDataReader obj_ywALL = PPH_SC.PPH_MAIN.get_ywAll(System.Configuration.ConfigurationManager.AppSettings["ConnectionString"]);
                                if (obj_ywALL.HasRows) {
                                while (obj_ywALL.Read()){
                            %>
                            <option value="<%= obj_ywALL["dateweek"].ToString() %>" <% if (strWeek == obj_ywALL["dateweek"].ToString()) { Response.Write("selected"); } %>><%= obj_ywALL["dateweek"].ToString() %></option>
                            <% } obj_ywALL.Close(); } %>
                        </select>
                    </div>
                    <div class="col-md-1" style="text-align:left;"><input type="button" value="Delete" class="btn btn-danger" onclick="js_BHrams_Delete('urlSubmit', 'week')" /></div>
                    <div class="col-md-7" style="text-align:left;"><input type="button" value="Rollback" class="btn btn-primary" onclick="js_BHrams_rollback('urlSubmit', 'week')" /></div>
                </div>     
                 <div class="row">
                    <div class="col-md-12"><div id="msg_process" style="padding:10px;">&nbsp;</div></div>
                </div>           
                <div class="row">
                    <div class="col-md-1"><label class="control-label">Keyword : </label></div>
                    <div class="col-md-3" style="text-align:left;"><input type="text" class="form-control" name="vendor" id="vendor" value="<%= strVendor %>" style="width:100%;" onkeydown = "return (event.keyCode!=13);" /></div>
                    <div class="col-md-8" style="text-align:left;"><input type="button" value="Search" class="btn btn-default" onclick="js_BHrams_Search('urlSubmit', 'week', 'vendor');" /></div>
                </div>
                <div class="row">
                    <div class="col-md-12" ><br /></div>
                </div>
            </div>
        </div>
        <% if(strVendor != "" && strWeek != ""){ %>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-bordered">
                    <tr style="background-color:#9bbb59;">
                        <td style="text-align:center;width:6%;">No.</td>
                        <td style="text-align:center;width:6%;">DC</td>
                        <td style="text-align:center;width:6%;">Week</td>
                        <td style="text-align:center;width:6%;">YEAR</td>
                        <td style="text-align:center;width:6%;">VD Code</td>
                        <td style="text-align:center;width:6%;">DEPT</td>
                        <td style="text-align:center;width:6%;">DEPT NAME</td>
                        <td style="text-align:center;width:6%;">Class Name</td>
                        <td style="text-align:center;width:6%;">STYLE</td>
                        <td style="text-align:center;width:16%;">DESC</td>
                        <td style="text-align:center;width:6%;">REC.CASE</td>
                        <td style="text-align:center;width:6%;">Rate</td>
                        <td style="text-align:center;width:6%;">Amount</td>
                        <td style="text-align:center;width:6%;">PO No</td>
                        <td style="text-align:center;width:6%;">Del Date</td>
                    </tr>
                    <%
                        int irows = 0, icolor = 0;
                        SqlDataReader obj_rams = PPH_SC.PPH_BH.get_bh_rams(System.Configuration.ConfigurationManager.AppSettings["ConnectionString"], strWeek, strVendor);
                        if (obj_rams.HasRows) {
                            while (obj_rams.Read()){
                                irows++;icolor++;
                                if (icolor == 1) { detailColor = "style=\"background-color:#ffffff;\""; } else { detailColor = "style=\"background-color:#f3f3f3;\""; icolor = 0; }
                    %>
                    <tr <%= detailColor %>>
                        <td style="text-align:center;"><%= irows %></td>
                        <td style="text-align:center;"><%= obj_rams["DC_No"].ToString() %></td>
                        <td style="text-align:center;"><%= obj_rams["Week"].ToString() %></td> 
                        <td style="text-align:center;"><%= obj_rams["Period"].ToString() %></td>
                        <td style="text-align:center;"><%= obj_rams["Vendor_Code"].ToString() %></td> 
                        <td style="text-align:center;"><%= obj_rams["Dept_Code"].ToString() %></td>        
                        <td style="text-align:center;"><%= obj_rams["Dept_Name"].ToString() %></td>
                        <td style="text-align:center;"><%= obj_rams["Class_Name"].ToString() %></td>
                        <td style="text-align:center;"><%= obj_rams["Style"].ToString() %></td>
                        <td style="text-align:center;"><%= obj_rams["Desciptions"].ToString() %></td>
                        <td style="text-align:center;"><%= obj_rams["Rec_Case"].ToString() %></td>
                        <td style="text-align:center;"><%= obj_rams["BH_Rate"].ToString() %></td>
                        <td style="text-align:center;"><%= obj_rams["BH_Amount"].ToString() %></td>
                        <td style="text-align:center;"><%= obj_rams["PO_No"].ToString() %></td>
                        <td style="text-align:center;"><%= obj_rams["str_delDate"].ToString() %></td>
                    </tr>
                    <% } obj_rams.Close();} %>
                </table>
            </div>
        </div>  
        <% } %>     
    </div>

</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="./pph_include/jquery/jquery-ui.js"></script>
<style>div.ui-datepicker{font-size:14px;}</style> 
<% Response.Write("<script>js_tab('" + strFrm + "')</script>"); %>
</asp:Content>
