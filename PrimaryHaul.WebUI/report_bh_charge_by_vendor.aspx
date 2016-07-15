<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="report_bh_charge_by_vendor.aspx.cs" Inherits="PrimaryHaul.WebUI.report_bh_charge_by_vendor" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="PrimaryHaul_WS"%>
<%@ Import Namespace="PrimaryHaul_WSFlow"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
<input type="hidden" name="urlSubmit" id="urlSubmit" value="<%= HttpContext.Current.Request.Url.AbsolutePath %>?r=<%= Request.QueryString["r"].ToString() %>&id=<%= Request.QueryString["id"].ToString() %>" />
<script>
    function js_tab(varTab) {
        window.location.href = document.getElementById('urlSubmit').value + '&form_view=' + varTab;
    }
       
    function ajax_listBHVD(var01, var02, var03, var04) {
        var req = Inint_AJAX();
        var str = Math.random();
        var adStart = document.getElementById(var01).value;
        var adEnd = document.getElementById(var02).value;
        if (adStart == "" || adEnd == "") {
            alert("ระบุ App Date Start และ App Date End");
        }
        else {
            var str_url_address = "./pph_include/ajax/files/ajax_listBHVD.aspx";
            var str_url = "var01=" + adStart;
            str_url += "&var02=" + adEnd;
            str_url += "&var03=" + var03;
            str_url += "&clearmemory=" + str;
            req.open('POST', str_url_address, true)
            req.onreadystatechange = function () {
                if (req.readyState == 4) {
                    if (req.status == 200) {
                        var strRes = req.responseText;
                        document.getElementById(var04).innerHTML = strRes;
                    }
                }
            }
            req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            req.send(str_url);
        }
    }

    function js_submit(obj_adStart, obj_adEnd, obj_adVD, obj_type, obj_form) {
        var adStart = document.getElementById(obj_adStart).value;
        var adEnd = document.getElementById(obj_adEnd).value;
        var adVD = document.getElementById(obj_adVD).value;
        if (adStart == "" || adEnd == "" || adVD == "") {
            alert("กรุณาเลือกข้อมูลให้ครบถ้วน");
        } else {
            if(obj_type==1)
            {
                if(obj_form=="form_view01")
                {
                    window.location.href = document.getElementById('urlSubmit').value + '&adStart=' + adStart + '&adEnd=' + adEnd + '&adVD=' + adVD + '&form_view=' + obj_form;
                }
                else
                {
                    window.location.href = document.getElementById('urlSubmit').value + '&adStart=' + adStart + '&adEnd=' + adEnd + '&adVD=' + adVD + '&form_view=' + obj_form;
                }
            } else {
                if (obj_form == "form_view01") {
                    window.open('./pph_include/download/bh_condition_summary_report.aspx?adStart=' + adStart + '&adEnd=' + adEnd + '&adVD=' + adVD, '_blank');
                }
                else {
                    window.open('./pph_include/download/bh_condition_report.aspx?adStart=' + adStart + '&adEnd=' + adEnd + '&adVD=' + adVD, '_blank');
                }
            }
        }
    }

</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />
<div id="form_button">
    <div class="row">
        <div class="col-md-12">
            <input type="button" value="Summary Report" class="btn btn-default" onclick="js_tab('form_view01');" />
            &nbsp;&nbsp;&nbsp;
            <input type="button" value="Details Report" class="btn btn-default" onclick="js_tab('form_view02');" />
        </div>
        <div class="col-md-8"></div>
    </div>
    <div class="row">
        <div class="col-md-12"><br /></div>
    </div>
</div>
<div id="form_view01" <% if (!string.IsNullOrEmpty(Request.QueryString["form_view"] as string)){if(Request.QueryString["form_view"].ToString()=="form_view02"){ %>style="display:none;"<% }} %>>
    <div class="form-group">
        <div class="row">
            <div class="col-md-12">
                <h4>Backhaul Charge by Vendor > Summary Report</h4>
                <hr />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">App Date Start</label></div>
            <div class="col-md-3"><input type="text" class="form-control" autocomplete="off" name="adSumStart" id="adSumStart" style="width:100%;"  <% if (!string.IsNullOrEmpty(Request.QueryString["adStart"] as string)){%>value="<%=Request.QueryString["adStart"] %>"<%} %> /></div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">App Date End</label></div>
            <div class="col-md-3"><input type="text" class="form-control" autocomplete="off" name="adSumEnd" id="adSumEnd" style="width:100%;" <% if (!string.IsNullOrEmpty(Request.QueryString["adEnd"] as string)){%>value="<%=Request.QueryString["adEnd"] %>"<%} %> onchange="ajax_listBHVD('adSumStart', 'adSumEnd', 'adSumVD', 'divSumVD');"/></div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Vendor</label></div>
            <div class="col-md-3">
                <div id="divSumVD">
                    <select class="form-control" id="adSumVD" name="adSumVD">
                        <% if (!string.IsNullOrEmpty(Request.QueryString["adVD"] as string)){
                            string[] adStartSum = Request.QueryString["adStart"].ToString().Split('/');
                            string[] adEndSum = Request.QueryString["adEnd"].ToString().Split('/');
                            SqlCommand cmd_vdSum = new SqlCommand("usp_BH_Vendor_Select_FromTransaction", objConn);
                            cmd_vdSum.CommandType = CommandType.StoredProcedure;
                            cmd_vdSum.Parameters.AddWithValue("@ApptDate_Start", "" + adStartSum[2] + "-" + adStartSum[1] + "-" + adStartSum[0] + "");
                            cmd_vdSum.Parameters.AddWithValue("@ApptDate_End", "" + adEndSum[2] + "-" + adEndSum[1] + "-" + adEndSum[0] + "");
                            SqlDataReader obj_vdSum = cmd_vdSum.ExecuteReader();
                            while (obj_vdSum.Read())
                            {
                                if (Request.QueryString["adVD"].ToString().Trim() == obj_vdSum["vendor_name"].ToString().Trim())
                                { Response.Write("<option value=\"" + obj_vdSum["vendor_name"] + "\" selected>" + obj_vdSum["vendor_name"] + "</option>"); }
                                else { Response.Write("<option value=\"" + obj_vdSum["vendor_name"] + "\">" + obj_vdSum["vendor_name"] + "</option>"); }
                            } obj_vdSum.Close();
                        }else{ %>
                        <option value="" selected="selected">ระบุ App Date Start และ App Date End</option>
                        <%} %>
                    </select>
                </div>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2" ><label class="control-label"></label></div>
            <div class="col-md-7" ><input type="button" value="Preview" class="btn btn-default" onclick="js_submit('adSumStart', 'adSumEnd', 'adSumVD', '1', 'form_view01');" id="btn1p" /><% if (!string.IsNullOrEmpty(Request.QueryString["form_view"] as string) && !string.IsNullOrEmpty(Request.QueryString["adVD"] as string)){if(Request.QueryString["form_view"].ToString()=="form_view01"){ %>&nbsp;&nbsp;&nbsp;<input type="button" value="Export To Excel" class="btn btn-default" onclick="js_submit('adSumStart', 'adSumEnd', 'adSumVD', '2', 'form_view01');" id="btn1e" /><%}} %></div>
        </div>
    </div>
    <% if (!string.IsNullOrEmpty(Request.QueryString["form_view"] as string) && !string.IsNullOrEmpty(Request.QueryString["adVD"] as string)){if(Request.QueryString["form_view"].ToString()=="form_view01"){ %>
    <div class="row">
        <div class="col-md-12">&nbsp;</div>
    </div> 
     <div class="row">
        <div class="col-md-12">
            <table class="table table-bordered">
            <tr style="background-color:#9bbb59;">
                <td style="text-align:center;">Vendor Code</td>
                <td style="text-align:center;">Vendor Name (by location)</td>
                <td style="text-align:center;">DC</td>
                <td style="text-align:center;">Sum of Load (RCVD)</td>
                <td style="text-align:center;">Sum of Case RCVD</td>
                <td style="text-align:center;">Sum of BHA</td>
            </tr>
            <%
                string detailColor = "";
                int irows = 0, icolor = 0, intSumLoad=0, intSumCase=0;
                decimal totalBHA = 0;
                string[] adStart = Request.QueryString["adStart"].ToString().Split('/');
                string[] adEnd = Request.QueryString["adEnd"].ToString().Split('/');
                SqlCommand cmd = new SqlCommand("usp_BH_Charge_by_Vendor_Summary", objConn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ApptDate_Start", "" + adStart[2] + "-" + adStart[1] + "-" + adStart[0] + "");
                cmd.Parameters.AddWithValue("@ApptDate_End", "" + adEnd[2] + "-" + adEnd[1] + "-" + adEnd[0] + "");
                cmd.Parameters.AddWithValue("@Vendor_Name", Request.QueryString["adVD"].ToString());
                SqlDataReader obj_result = cmd.ExecuteReader();
                if (obj_result.HasRows){
                    while (obj_result.Read()){
                        irows++;icolor++;
                        if (icolor == 1) { detailColor = "style=\"background-color:#ffffff;\""; } else { detailColor = "style=\"background-color:#f3f3f3;\""; icolor = 0; }
                        if (obj_result["Sum_Load_RCVD"].ToString() != "") { intSumLoad = intSumLoad + Convert.ToInt32(obj_result["Sum_Load_RCVD"].ToString()); }
                        if (obj_result["Sum_RAMS_Case_RCVD"].ToString() != "") { intSumCase = intSumCase + Convert.ToInt32(obj_result["Sum_RAMS_Case_RCVD"].ToString()); }
                        if (obj_result["Sum_RAMS_Case_Baht"].ToString() != "") { totalBHA = totalBHA + Convert.ToDecimal(obj_result["Sum_RAMS_Case_Baht"].ToString()); }
            %>
            <tr <%= detailColor %>>
                <td style="text-align:center;"><%= obj_result["vendor_code"].ToString() %></td>
                <td style="text-align:center;"><%= obj_result["vendor_name"].ToString() %></td>
                <td style="text-align:center;"><%= obj_result["dc_no"].ToString() %></td>
                <td style="text-align:center;"><%= obj_result["Sum_Load_RCVD"].ToString() %></td>
                <td style="text-align:center;"><%= obj_result["Sum_RAMS_Case_RCVD"].ToString() %></td>
                <td style="text-align:center;"><%= obj_result["Sum_RAMS_Case_Baht"].ToString() %></td>
            </tr>
            <% } obj_result.Close();} %>
            <tr style="background-color:#9bbb59;">
                <td style="text-align:center;" colspan="3"></td>
                <td style="text-align:center;"><%= intSumLoad %></td>
                <td style="text-align:center;"><%= intSumCase %></td>
                <td style="text-align:center;"><%= totalBHA %></td>
            </tr>
            </table>
        </div>
    </div>
    <% }} %>
</div>
<div id="form_view02" <% if (!string.IsNullOrEmpty(Request.QueryString["form_view"] as string)){if(Request.QueryString["form_view"].ToString()=="form_view01"){ %>style="display:none;"<% }} %>>
    <div class="form-group">
        <div class="row">
            <div class="col-md-12">
                <h4>Backhaul Charge by Vendor > Details Report</h4>
                <hr />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">App Date Start</label></div>
            <div class="col-md-3"><input type="text" class="form-control" autocomplete="off" name="adStart" id="adStart" style="width:100%;" <% if (!string.IsNullOrEmpty(Request.QueryString["adStart"] as string)){%>value="<%=Request.QueryString["adStart"] %>"<%} %> /></div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">App Date End</label></div>
            <div class="col-md-3"><input type="text" class="form-control" autocomplete="off" name="adEnd" id="adEnd" style="width:100%;" <% if (!string.IsNullOrEmpty(Request.QueryString["adEnd"] as string)){%>value="<%=Request.QueryString["adEnd"] %>"<%} %> onchange="ajax_listBHVD('adStart', 'adEnd', 'adVD', 'divVD');"/></div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2"><label class="control-label">Vendor</label></div>
            <div class="col-md-3">
                <div id="divVD">
                    <select class="form-control" id="adVD" name="adVD">
                        <% if (!string.IsNullOrEmpty(Request.QueryString["adVD"] as string)){
                            string[] adStartS = Request.QueryString["adStart"].ToString().Split('/');
                            string[] adEndS = Request.QueryString["adEnd"].ToString().Split('/');
                            SqlCommand cmd_getYW = new SqlCommand("usp_BH_Vendor_Select_FromTransaction", objConn);
                            cmd_getYW.CommandType = CommandType.StoredProcedure;
                            cmd_getYW.Parameters.AddWithValue("@ApptDate_Start", "" + adStartS[2] + "-" + adStartS[1] + "-" + adStartS[0] + "");
                            cmd_getYW.Parameters.AddWithValue("@ApptDate_End", "" + adEndS[2] + "-" + adEndS[1] + "-" + adEndS[0] + "");
                            SqlDataReader obj_vd = cmd_getYW.ExecuteReader();
                            while (obj_vd.Read())
                            {
                                if (Request.QueryString["adVD"].ToString().Trim() == obj_vd["vendor_name"].ToString().Trim())
                                { Response.Write("<option value=\"" + obj_vd["vendor_name"] + "\" selected>" + obj_vd["vendor_name"] + "</option>"); }
                                else { Response.Write("<option value=\"" + obj_vd["vendor_name"] + "\">" + obj_vd["vendor_name"] + "</option>"); }                             
                            } obj_vd.Close();
                        }else{ %>
                        <option value="" selected="selected">ระบุ App Date Start และ App Date End</option>
                        <%} %>
                    </select>
                </div>
            </div>
            <div class="col-md-7"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-md-2" ><label class="control-label"></label></div>
            <div class="col-md-7" ><input type="button" value="Preview" class="btn btn-default" onclick="js_submit('adStart', 'adEnd', 'adVD', '1', 'form_view02');" id="btn2p" /><% if (!string.IsNullOrEmpty(Request.QueryString["form_view"] as string) && !string.IsNullOrEmpty(Request.QueryString["adVD"] as string)){if(Request.QueryString["form_view"].ToString()=="form_view02"){ %>&nbsp;&nbsp;&nbsp;<input type="button" value="Export To Excel" class="btn btn-default" onclick="    js_submit('adStart', 'adEnd', 'adVD', '2', 'form_view02');" id="btn2e" /><%}} %></div>
        </div>
    </div>
    <% if (!string.IsNullOrEmpty(Request.QueryString["form_view"] as string) && !string.IsNullOrEmpty(Request.QueryString["adVD"] as string)){if(Request.QueryString["form_view"].ToString()=="form_view02"){ %>
    <div class="row">
        <div class="col-md-12">&nbsp;</div>
    </div> 
     <div class="row">
        <div class="col-md-12">
            <table class="table table-bordered">
            <tr style="background-color:#9bbb59;">
                <td style="text-align:center;">Vendor Code</td>
                <td style="text-align:center;">Wk (appt)</td>
                <td style="text-align:center;">Period (appt)</td>
                <td style="text-align:center;">Vendor Name (by location)</td>
                <td style="text-align:center;">Appt Date</td>
                <td style="text-align:center;">Load (appt)</td>
                <td style="text-align:center;">Load (RCVD)</td>
                <td style="text-align:center;">PO</td>
                <td style="text-align:center;">DC</td>
                <td style="text-align:center;">Case RCVD</td>
                <td style="text-align:center;">BHA</td>
            </tr>
            <%
                string detailColor = "";
                int irows = 0, icolor = 0, intSumLoadAppt = 0, intSumLoadRCVD = 0, intSumCase = 0;
                decimal totalBHA = 0;
                string[] adStartD = Request.QueryString["adStart"].ToString().Split('/');
                string[] adEndD = Request.QueryString["adEnd"].ToString().Split('/');
                SqlCommand cmdD = new SqlCommand("usp_BH_Charge_by_Vendor_Details", objConn);
                cmdD.CommandType = CommandType.StoredProcedure;
                cmdD.Parameters.AddWithValue("@ApptDate_Start", "" + adStartD[2] + "-" + adStartD[1] + "-" + adStartD[0] + "");
                cmdD.Parameters.AddWithValue("@ApptDate_End", "" + adEndD[2] + "-" + adEndD[1] + "-" + adEndD[0] + "");
                cmdD.Parameters.AddWithValue("@Vendor_Name", Request.QueryString["adVD"].ToString());
                SqlDataReader obj_resultD = cmdD.ExecuteReader();
                if (obj_resultD.HasRows){
                    while (obj_resultD.Read()){
                        irows++;icolor++;
                        if (icolor == 1) { detailColor = "style=\"background-color:#ffffff;\""; } else { detailColor = "style=\"background-color:#f3f3f3;\""; icolor = 0; }
                        if (obj_resultD["Load_Appt"].ToString() != "") { intSumLoadAppt = intSumLoadAppt + Convert.ToInt32(obj_resultD["Load_Appt"].ToString()); }
                        if (obj_resultD["Load_Rcvd"].ToString() != "") { intSumLoadRCVD = intSumCase + Convert.ToInt32(obj_resultD["Load_Rcvd"].ToString()); }
                        if (obj_resultD["RAMS_Case_RCVD"].ToString() != "") { intSumCase = intSumCase + Convert.ToInt32(obj_resultD["RAMS_Case_RCVD"].ToString()); }
                        if (obj_resultD["RAMS_Case_Baht"].ToString() != "") { totalBHA = totalBHA + Convert.ToDecimal(obj_resultD["RAMS_Case_Baht"].ToString().Replace(",","")); }
            %>
            <tr <%= detailColor %>>
                <td style="text-align:center;"><%= obj_resultD["vendor_code"].ToString() %></td>
                <td style="text-align:center;"><%= obj_resultD["Wk_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_resultD["Period_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_resultD["vendor_name"].ToString() %></td>
                <td style="text-align:center;"><%= Convert.ToDateTime(obj_resultD["Appt_Date"].ToString()).ToString("dd/MM/yyyy") %></td>
                <td style="text-align:center;"><%= obj_resultD["Load_Appt"].ToString() %></td>
                <td style="text-align:center;"><%= obj_resultD["Load_Rcvd"].ToString() %></td>
                <td style="text-align:center;"><%= obj_resultD["Po_No"].ToString() %></td>
                <td style="text-align:center;"><%= obj_resultD["DC_No"].ToString() %></td>
                <td style="text-align:center;"><%= obj_resultD["RAMS_Case_RCVD"].ToString() %></td>
                <td style="text-align:center;"><%= obj_resultD["RAMS_Case_Baht"].ToString() %></td>
            </tr>
            <% } obj_resultD.Close();} %>
            <tr style="background-color:#9bbb59;">
                <td style="text-align:center;" colspan="5"></td>
                <td style="text-align:center;"><%= intSumLoadAppt %></td>
                <td style="text-align:center;"><%= intSumLoadRCVD %></td>
                <td style="text-align:center;" colspan="2"></td>
                <td style="text-align:center;"><%= intSumCase %></td>
                <td style="text-align:center;"><%= totalBHA %></td>
            </tr>
            </table>
        </div>
    </div>
    <% }} %>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="./pph_include/jquery/jquery-ui.js"></script>
<script>

    $(function () {

        $("#adSumStart").datepicker({ dateFormat: 'dd/mm/yy' });
        $("#adSumEnd").datepicker({ dateFormat: 'dd/mm/yy'});

        $("#adStart").datepicker({ dateFormat: 'dd/mm/yy' });
        $("#adEnd").datepicker({ dateFormat: 'dd/mm/yy'});

    });

</script>
<style>
    div.ui-datepicker{
        font-size:14px;
    }
</style> 
</asp:Content>
