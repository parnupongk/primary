<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="master_ratecard.aspx.cs" Inherits="PrimaryHaul.WebUI.master_ratecard" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
    <script>
        function js_tab(varTab) {
            document.getElementById('form_view').style.display = 'none';
            document.getElementById('form_import').style.display = 'none';
            document.getElementById('form_add').style.display = 'none';
            document.getElementById(varTab).style.display = '';
        }
        function alertMessage(str) {
            alert(str);
        }
    </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"
        type="text/javascript"></script>
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css"
        rel="Stylesheet" type="text/css" />

    <script type="text/javascript">
        $(document).ready(function () {
            SearchText();
        });
        function SearchText() {
            $("#<%=txtVendorCode.ClientID %>").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: '<%=ResolveUrl("~/AutoComplete.asmx/GetVendorCode") %>',
                        data: "{ 'prefixText': '" + request.term + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('-')[0],
                                    val: item.split('-')[1]
                                }
                            }))
                        },
                        error: function (result) {
                            alert(response.responseText);
                        }
                    });
                },
                focus: function () {
                    // prevent value inserted on focus
                    return false;
                },
                select: function (event, ui) {
                    var terms = split(this.value);
                    // remove the current input
                    terms.pop();
                    // add the selected item
                    terms.push(ui.item.label);
                    // add placeholder to get the comma-and-space at the end
                    document.getElementById('<%=txtVendorName.ClientID%>').value = ui.item.val;
                    //terms.push("");
                    //this.value = terms.join(", ");
                    this.value = terms;
                    return false;
                }
            });
            $("#<%=txtVendorCode.ClientID %>").bind("keydown", function (event) {
                if (event.keyCode === $.ui.keyCode.TAB &&
                $(this).data("autocomplete").menu.active) {
                    event.preventDefault();
                }
            })
            function split(val) {
                return val.split(/,\s*/);
            }
            function extractLast(term) {
                return split(term).pop();
            }
        }
    </script>
    <div class="form-horizontal">
        <h4>Master > Rate Card</h4>
        <hr />

        <div id="form_button">
            <div class="row">
                <div class="col-md-4">
                    <input type="button" value="Import" class="btn btn-default" onclick="js_tab('form_import');" />&nbsp;&nbsp;&nbsp;
                <input type="button" value="Add" class="btn btn-default" onclick="js_tab('form_add');" />&nbsp;&nbsp;&nbsp;
                <input type="button" value="View Data" class="btn btn-default" onclick="js_tab('form_view');" />
                </div>
                <div class="col-md-8"></div>
            </div>
        </div>
        <div id="form_import" style="display: none;">
            <div runat="server" class="form-group">
                <asp:Label runat="server" AssociatedControlID="lnkFile" CssClass="col-md-3 control-label"></asp:Label>
                <div class="col-md-9">
                    <a runat="server" id="lnkFile" href="file/ratecard.xls" target="_blank" >file ตัวอย่าง</a>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="AjaxFileUpload" CssClass="col-md-3 control-label">Import File :</asp:Label>
                <div class="col-md-9">

                    <asp:AjaxFileUpload ID="AjaxFileUpload" runat="server" Padding-Bottom="4"
                        Padding-Left="2" Padding-Right="1" Padding-Top="4" ThrobberID="myThrobber" MaximumNumberOfFiles="10"
                        AllowedFileTypes="xls,vnd.ms-excel,xls,jpg,png,application/vnd.ms-excel" OnUploadComplete="AjaxFileUpload_UploadComplete" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-3 col-md-9">
                    <asp:Button runat="server" ID="btnSubmit" Text="Submit" CssClass="btn btn-default" OnClick="btnSubmit_Click" />
                    <p class="text-danger">
                        <asp:Label ID="lblErr" runat="server"></asp:Label>
                    </p>
                </div>
            </div>
        </div>
        <div id="form_add" style="display: none;">

            <div runat="server" class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtVendorCode" CssClass="col-md-3 control-label">Vendor Code</asp:Label>
                <div class="col-md-9">
                    <asp:TextBox runat="server" ID="txtVendorCode" CssClass="form-control" onkeypress="return isNumberKey(event)" MaxLength="5" />
                    <asp:HiddenField ID="hfCustomerId" runat="server" />
                    <asp:RequiredFieldValidator runat="server" ValidationGroup="Add" ControlToValidate="txtVendorCode" CssClass="text-danger" ErrorMessage="The Vendor Code is required." />
                </div>
            </div>
            <div runat="server" class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtVendorName" CssClass="col-md-3 control-label">Vendor Name</asp:Label>
                <div class="col-md-9">
                    <asp:TextBox autocomplete="off" runat="server" ID="txtVendorName" onkeypress="return false;" CssClass="form-control" />
                    <br />
                </div>
            </div>
            <div runat="server" class="form-group">
                <asp:Label runat="server" AssociatedControlID="ddlCollectionPoint" CssClass="col-md-3 control-label">Collection_Point</asp:Label>
                <div class="col-md-9">

                    <asp:DropDownList ID="ddlCollectionPoint" runat="server" CssClass="form-control"></asp:DropDownList>
                    <br />
                </div>
            </div>
            <div runat="server" class="form-group">
                <asp:Label runat="server" AssociatedControlID="ddlDC" CssClass="col-md-3 control-label">DC</asp:Label>
                <div class="col-md-9">

                    <asp:DropDownList ID="ddlDC" runat="server" CssClass="form-control"></asp:DropDownList>
                    <br />
                </div>
            </div>
            <div runat="server" class="form-group">
                <asp:Label runat="server" AssociatedControlID="ddlRateType" CssClass="col-md-3 control-label">Charge Type</asp:Label>
                <div class="col-md-9">

                    <asp:DropDownList ID="ddlRateType" runat="server" CssClass="form-control"></asp:DropDownList>
                    <br />
                </div>
            </div>
            <div runat="server" class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtRateFrom" CssClass="col-md-3 control-label">Fuel Rate From</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox autocomplete="off" runat="server" ID="txtRateFrom" CssClass="form-control" onkeypress="return isNumberKey(event)" />
                    <asp:RequiredFieldValidator runat="server" ValidationGroup="Add" ControlToValidate="txtRateFrom" CssClass="text-danger" ErrorMessage="The Fuel Rate From is required." />
                </div>
                <div class="col-md-1">
                    TO
                </div>
                <div class="col-md-2">
                    <asp:TextBox autocomplete="off" runat="server" ID="txtRateTo" CssClass="form-control" onkeypress="return isNumberKey(event)" />
                    <asp:RequiredFieldValidator runat="server" ValidationGroup="Add" ControlToValidate="txtRateTo" CssClass="text-danger" ErrorMessage="The Fuel Rate To is required." />
                </div>
            </div>

            <div runat="server" class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtBuyRate" CssClass="col-md-3 control-label">Buy Rate</asp:Label>
                <div class="col-md-9">
                    <asp:TextBox autocomplete="off" runat="server" ID="txtBuyRate" CssClass="form-control" onkeypress="return isNumberKey(event)" />
                    <asp:RequiredFieldValidator runat="server" ValidationGroup="Add" ControlToValidate="txtBuyRate" CssClass="text-danger" ErrorMessage="The Buy Rate From is required." />
                </div>
            </div>

            <div runat="server" class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtSellRate" CssClass="col-md-3 control-label">Sell Rate</asp:Label>
                <div class="col-md-9">
                    <asp:TextBox autocomplete="off" runat="server" ID="txtSellRate" CssClass="form-control" onkeypress="return isNumberKey(event)" />
                    <asp:RequiredFieldValidator runat="server" ValidationGroup="Add" ControlToValidate="txtSellRate" CssClass="text-danger" ErrorMessage="The Sell Rate From is required." />
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Button runat="server" ID="btnAddSubmit" ValidationGroup="Add" Text="Submit" CssClass="btn btn-default" OnClick="btnAddSubmit_Click" />
                    <p class="text-danger">
                        <asp:Label ID="Label1" runat="server"></asp:Label>
                    </p>
                </div>
            </div>

        </div>
        <div id="form_view" style="display: ;">
            <asp:GridView ID="gvData" DataKeyNames="RateCard_ID" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowCancelingEdit="gvData_RowCancelingEdit" OnRowDataBound="gvData_RowDataBound" OnRowEditing="gvData_RowEditing" OnRowUpdating="gvData_RowUpdating" Width="100%" CellSpacing="2">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Vendor_Code" HeaderText="Vendor_Code" ReadOnly="True" />
                    <asp:BoundField DataField="Vendor_Name" HeaderText="Vendor_Name" ReadOnly="True" />
                    <asp:BoundField DataField="Collection_Point" HeaderText="Collection_Point" ReadOnly="True" />
                    <asp:BoundField DataField="Transporter_Desc" HeaderText="Transporter_Desc" ReadOnly="True" />
                    <asp:BoundField DataField="DC_No" HeaderText="DC_No" ReadOnly="True" />
                    <asp:BoundField DataField="Sell_Rate" HeaderText="Sell_Rate" ReadOnly="True" />
                    <asp:BoundField DataField="Sell_RateType" HeaderText="Sell_RateType" ReadOnly="True" />
                    <asp:BoundField DataField="StartDate" HeaderText="StartDate" ReadOnly="True" DataFormatString="{0:MM/dd/yyyy}" />
                    <asp:TemplateField HeaderText="EndDate">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEndDate" runat="server" Text='<%# Bind("enddate") %>'>
                            </asp:TextBox>
                            <asp:CalendarExtender ID="CalendarExtender1" runat="server"
                                TargetControlID="txtEndDate" PopupButtonID="txtEndDate"
                                Format="MM/dd/yyyy">
                            </asp:CalendarExtender>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblendDate" Text='<%# Bind("enddate", "{0:MM/dd/yyyy}") %>' runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" />
                </Columns>
                <EditRowStyle BackColor="#7C6F57" />
                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#E3EAEB" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                <SortedAscendingHeaderStyle BackColor="#246B61" />
                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                <SortedDescendingHeaderStyle BackColor="#15524A" />
            </asp:GridView>

        </div>

    </div>
</asp:Content>
