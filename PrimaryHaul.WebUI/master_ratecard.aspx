<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="master_ratecard.aspx.cs" Inherits="PrimaryHaul.WebUI.master_ratecard" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
    <style type="text/css">
        .paginationr {
            line-height: 26px;
        }

            .paginationr span {
                padding: 5px;
                border: solid 1px #477B0E;
                text-decoration: none;
                white-space: nowrap;
                background: #547B2A;
            }

            .paginationr a,
            .paginationr a:visited {
                text-decoration: none;
                padding: 6px;
                white-space: nowrap;
            }

                .paginationr a:hover,
                .paginationr a:active {
                    padding: 5px;
                    border: solid 1px #9ECDE7;
                    text-decoration: none;
                    white-space: nowrap;
                    background: #486694;
                }
    </style>
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
        function UploadComplete() {
            document.getElementById('<%= btnSubmit.ClientID %>').disabled = false;
        }

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
                    <input type="button" runat="server" id="btnImport" value="Import" class="btn btn-default" onclick="js_tab('form_import');" />&nbsp;&nbsp;&nbsp;
                <input type="button" runat="server" id="btnAdd" value="Add" class="btn btn-default" onclick="js_tab('form_add');" />&nbsp;&nbsp;&nbsp;
                <input type="button" value="View Data" class="btn btn-default" onclick="js_tab('form_view');" />
                </div>
                <div class="col-md-8"></div>
            </div>
        </div>
        <div id="form_import" style="display: none;">
            <div runat="server" class="form-group">
                <asp:Label runat="server" AssociatedControlID="lnkFile" CssClass="col-md-3 control-label"></asp:Label>
                <div class="col-md-9">
                    <a runat="server" id="lnkFile" href="file/ratecard.xls" target="_blank">file ตัวอย่าง</a>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="AjaxFileUpload" CssClass="col-md-3 control-label">Import File :</asp:Label>
                <div class="col-md-9">

                    <asp:AjaxFileUpload ID="AjaxFileUpload" runat="server" Padding-Bottom="4"
                        Padding-Left="2" Padding-Right="1" Padding-Top="4" ThrobberID="myThrobber" MaximumNumberOfFiles="10" OnClientUploadCompleteAll="UploadComplete"
                        AllowedFileTypes="xls,vnd.ms-excel,application/vnd.ms-excel,xlsx" OnUploadComplete="AjaxFileUpload_UploadComplete" />
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
            <div runat="server" class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtVendorName" CssClass="col-md-3 control-label">Vendor Name</asp:Label>
                <div class="col-md-2">
                    <asp:TextBox ID="txtFillVendorName" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <asp:Button ID="btnFillter" CssClass="btn btn-default" runat="server" Text="Search" OnClick="btnFillter_Click" />
                </div>
            </div>
            <asp:GridView ID="gvData" DataKeyNames="RateCard_ID" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowCancelingEdit="gvData_RowCancelingEdit" OnRowDataBound="gvData_RowDataBound" OnRowEditing="gvData_RowEditing" OnRowUpdating="gvData_RowUpdating" Width="100%" AllowPaging="True" OnPageIndexChanging="gvData_PageIndexChanging" PageIndex="0" PageSize="100">
                <AlternatingRowStyle BackColor="White" HorizontalAlign="Center" />
                <Columns>
                    <asp:BoundField DataField="Vendor_Code" HeaderText="Vendor Code" ReadOnly="True" />
                    <asp:BoundField DataField="Vendor_Name" HeaderText="Vendor Name" ReadOnly="True">
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Collection_Point" HeaderText="Collection Point" ReadOnly="True">
                        <HeaderStyle Width="180px" HorizontalAlign="Center" ></HeaderStyle>

                        <ItemStyle Width="180px" HorizontalAlign="Left"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="DC_ABBR" HeaderText="DC Abbr" ReadOnly="True" />
                    <asp:BoundField DataField="buy_ratetype" HeaderText="Buy Rate Type" ReadOnly="True" />
                    <asp:BoundField DataField="buy_rate" HeaderText="Buy Rate" ReadOnly="True" />
                    <asp:BoundField DataField="Sell_RateType" HeaderText="Sell Rate Type" ReadOnly="True" />
                    <asp:BoundField DataField="Sell_Rate" HeaderText="Sell Rate" ReadOnly="True" />
                    <asp:BoundField DataField="fuel_rate_from" HeaderText="Fuel Rate From" ReadOnly="True" />
                    <asp:BoundField DataField="fuel_rate_to" HeaderText="Fuel Rate To" ReadOnly="True" />
                    <asp:BoundField DataField="StartDate" HeaderText="Start Date" ReadOnly="True" DataFormatString="{0:dd/MM/yyyy}">
                        <HeaderStyle Width="120px" HorizontalAlign="Center"></HeaderStyle>

                        <ItemStyle Width="120px" HorizontalAlign="Center"></ItemStyle>
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="End Date">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEndDate" runat="server" Text='<%# Bind("enddate") %>'>
                            </asp:TextBox>
                            <asp:CalendarExtender ID="CalendarExtender1" runat="server"
                                TargetControlID="txtEndDate" PopupButtonID="txtEndDate"
                                Format="dd/MM/yyyy">
                            </asp:CalendarExtender>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblendDate" Text='<%# Bind("enddate", "{0:dd/MM/yyyy}") %>' runat="server"></asp:Label>
                        </ItemTemplate>

                        <HeaderStyle Width="120px" HorizontalAlign="Center"></HeaderStyle>

                        <ItemStyle Width="120px" HorizontalAlign="Center"></ItemStyle>
                    </asp:TemplateField>
                   <asp:CommandField ShowEditButton="True" />
                </Columns>
                <EditRowStyle BackColor="#7C6F57" />
                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                <PagerSettings FirstPageText="&lt;&lt;" LastPageText="&gt;&gt;" NextPageText="&amp;gt;&amp;gt;" Position="TopAndBottom" PreviousPageText="&amp;lt;&amp;lt;&amp;lt;" />
                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#E3EAEB" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                <SortedAscendingHeaderStyle BackColor="#246B61" />
                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                <SortedDescendingHeaderStyle BackColor="#15524A" />
                <PagerStyle CssClass="paginationr" HorizontalAlign="Center" />
            </asp:GridView>
            <!-- 
                 <asp:CommandField ShowEditButton="True" />
                <asp:BoundField DataField="DC_No" HeaderText="DC No" ReadOnly="True" />
                <asp:BoundField DataField="Transporter_Desc" HeaderText="Transporter Desc" ReadOnly="True" />
                -->
        </div>

    </div>
</asp:Content>
