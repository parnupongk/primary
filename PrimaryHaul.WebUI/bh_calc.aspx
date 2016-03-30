<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="bh_calc.aspx.cs" Inherits="PrimaryHaul.WebUI.bh_calc" %>
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
                    <asp:DropDownList ID="ddlDateWeek" runat="server" CssClass="form-control" ></asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-3 col-md-9">
                    <asp:Button runat="server" ID="btnSubmit" Visible="true" Text="Submit" CssClass="btn btn-default" OnClick="btnSubmit_Click" />
                    <p class="text-danger">
                        <asp:Label ID="lblErr" runat="server"></asp:Label>
                    </p>
                </div>
            </div>
        </div>
        <div id="form_view" style="display: ;">
            <asp:GridView ID="gvData" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" CellSpacing="2" OnRowDataBound="gvData_RowDataBound" OnRowDeleting="gvData_RowDeleting" OnRowCommand="gvData_RowCommand">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="No.">
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="Week" HeaderText="Week" ReadOnly="True" >
                    <ItemStyle Width="500px" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="File_Name" HeaderText="File_Name" ReadOnly="True" >
                    <HeaderStyle HorizontalAlign="Left" />
                    <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="RowNo" HeaderText="RowNo" ReadOnly="True" >
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Status_Calc" HeaderText="Status_Calc" ReadOnly="True" >
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="btnCalc" runat="server" CommandName="Calc">Calculate</asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" 
                                onclientclick="return confirm('Are you sure you want to delete this record?');"  
                                CommandName="Delete" ImageUrl="~/images/icon_trashcan.gif" 
                                Text="Delete" />
                        </ItemTemplate>
                        <ItemStyle Width="100px" HorizontalAlign="Center" />
                    </asp:TemplateField>

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
