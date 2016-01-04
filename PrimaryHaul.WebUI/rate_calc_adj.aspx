<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="rate_calc_adj.aspx.cs" Inherits="PrimaryHaul.WebUI.rate_calc_adj" %>

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
        <h4>Rate Calculation &gt; Adjust</h4>
        <hr />
        <div id="form_import" style="display: ;">
            <div runat="server" class="form-group">
                <asp:Label runat="server" AssociatedControlID="ddlDateWeek" CssClass="col-md-2 control-label">Year-Week </asp:Label>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlDateWeek" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>

                <asp:Label runat="server" AssociatedControlID="ddlHaluier" CssClass="col-md-2 control-label">Haulier </asp:Label>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlHaluier" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>

                <asp:Label runat="server" AssociatedControlID="txtVendorCode" CssClass="col-md-2 control-label">Vendor Code </asp:Label>
                <div class="col-md-2">
                    <asp:TextBox runat="server" ID="txtVendorCode" CssClass="form-control" onkeypress="return isNumberKey(event)" MaxLength="5" />
                </div>

            </div>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-1">
                    <asp:Button runat="server" ID="btnSearch" Text="Search" CssClass="btn btn-default" OnClick="btnSearch_Click" />
                    <p class="text-danger">
                        <asp:Label ID="lblErr" runat="server"></asp:Label>
                    </p>
                </div>
                <div class="col-md-1">
                    <asp:Button runat="server" ID="btnCalc" Text="Calculate" CssClass="btn btn-default" OnClick="btnCalc_Click" />
                </div>
            </div>
        </div>
        <div id="form_view" style="display: ;">
            <asp:GridView ID="gvData" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" CellSpacing="4" OnRowCommand="gvData_RowCommand" OnRowCancelingEdit="gvData_RowCancelingEdit" OnRowEditing="gvData_RowEditing" DataKeyNames="transid" OnRowUpdating="gvData_RowUpdating" OnRowDataBound="gvData_RowDataBound">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Haulier_Abbr" HeaderText="Haulier Abbr" ReadOnly="True" >
                        <HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
                        <ItemStyle Width="50px" HorizontalAlign="Center"></ItemStyle>
                    </asp:BoundField> 
                    <asp:BoundField DataField="Po_No" HeaderText="Po No" ReadOnly="True" >
                        <ControlStyle Width="120px" />
                        <FooterStyle Width="120px" />
                        <HeaderStyle Width="130px" ></HeaderStyle>
                        <ItemStyle Width="130px" ></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Delivery_Ref" HeaderText="Delivery Ref" ReadOnly="True" >
                        <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                        <ItemStyle Width="80px" HorizontalAlign="Center"></ItemStyle>
                    </asp:BoundField> 
                    <asp:BoundField DataField="Delivery_Date" HeaderText="Delivery Date" ReadOnly="True" />
                    <asp:BoundField DataField="Vendor_Code" HeaderText="Vendor Code" ReadOnly="True" > 
                        <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                        <ItemStyle Width="80px" HorizontalAlign="Center"></ItemStyle>
                    </asp:BoundField>  
                    <asp:BoundField DataField="Vendor_Name" HeaderText="Vendor Name" ReadOnly="True" />
                    <asp:BoundField DataField="Collection_Point" HeaderText="Collection Point" ReadOnly="True" />
                    <asp:BoundField DataField="Delivery_Location" HeaderText="Delivery Location" ReadOnly="True" >
                        <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                        <ItemStyle Width="80px" HorizontalAlign="Center"></ItemStyle>
                    </asp:BoundField>  
                    <asp:BoundField DataField="Fuel_Rate" HeaderText="Fuel Rate" ReadOnly="True">
                        <HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
                        <ItemStyle Width="50px" HorizontalAlign="Center"></ItemStyle>
                    </asp:BoundField>   
                    <asp:TemplateField HeaderText="Qty">
                            <HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
                            <ItemStyle Width="50px" HorizontalAlign="Center"></ItemStyle>
                        <EditItemTemplate>
                            <div>
                                <asp:TextBox ID="txtOldNoQty" Text='<%# "-" + Eval("No_Of_Qty")%>' CssClass="form-control" runat="server"></asp:TextBox></div>
                            <div>
                                <asp:TextBox ID="txtNewNoQty" Text='<%# Eval("No_Of_Qty")%>' CssClass="form-control" runat="server"></asp:TextBox></div>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("No_Of_Qty") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField EditText="Adjust Data" ShowEditButton="True" >
                                                <ControlStyle Width="70px" />
                        <FooterStyle Width="70px" />
                        <HeaderStyle Width="70px"></HeaderStyle>
                        <ItemStyle Width="90px" HorizontalAlign="Center"></ItemStyle>
                        </asp:CommandField>
                    <asp:BoundField DataField="Trans_Type" HeaderText="Trans_Type" ReadOnly="True"  Visible="false"/>
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
            <!--
                                    <asp:BoundField DataField="Remark1" HeaderText="Remark1" ReadOnly="True" />
                    <asp:BoundField DataField="Remark2" HeaderText="Remark2" ReadOnly="True" />
                        <asp:BoundField DataField="RateType" HeaderText="RateType" ReadOnly="True" />
                    <asp:BoundField DataField="No_Of_Qty" HeaderText="No_Of_Qty" ReadOnly="True" />
                    <asp:BoundField DataField="Rate_Per_Uint" HeaderText="Rate_Per_Uint" ReadOnly="True" />
                    <asp:BoundField DataField="Currency" HeaderText="Currency" ReadOnly="True" />
                    <asp:BoundField DataField="Addition_Cost" HeaderText="Addition_Cost" ReadOnly="True" />
                    <asp:BoundField DataField="Addition_Cost_Reason" HeaderText="Addition_Cost_Reason" ReadOnly="True" />
                    <asp:BoundField DataField="Total_Cost" HeaderText="Total_Cost" ReadOnly="True" />
                    <asp:BoundField DataField="Year_Week_No" HeaderText="Year_Week_No" ReadOnly="True" /> 
>>>>>>> origin/master -->
        </div>
    </div>
</asp:Content>
