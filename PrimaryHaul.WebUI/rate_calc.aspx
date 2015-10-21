<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="rate_calc.aspx.cs" Inherits="PrimaryHaul.WebUI.rate_calc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
    <script>
        function alertMessage(str) {
            alert(str);
        }
    </script>
    <div class="form-horizontal">
        <h4>Rate Calculation </h4>
        <hr />
        <div id="form_import" style="display: ;">
            <div runat="server" class="form-group">
                <asp:Label runat="server" AssociatedControlID="ddlDateWeek" CssClass="col-md-3 control-label">Week </asp:Label>
                <div class="col-md-9">
                    <asp:DropDownList ID="ddlDateWeek" AutoPostBack="true" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlDateWeek_SelectedIndexChanged"></asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-3 col-md-9">
                    <asp:Button runat="server" ID="btnAddSubmit" Text="Calculate" CssClass="btn btn-default" OnClick="btnAddSubmit_Click" />
                    <p class="text-danger">
                        <asp:Label ID="lblErr" runat="server"></asp:Label>
                    </p>
                </div>
            </div>
        </div>
        <div id="form_view" style="display: ;">
            <asp:GridView ID="gvData" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" CellSpacing="2" OnRowDataBound="gvData_RowDataBound">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="No.">
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Haulier_Abbr" HeaderText="Haulier Abbr" ReadOnly="True" />
                    <asp:BoundField DataField="Status_Upload" HeaderText="Upload Status" ReadOnly="True" />
                    <asp:BoundField DataField="Status_Calculate" HeaderText="Calc. Status" ReadOnly="True" />

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
