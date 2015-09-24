<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="haulier_upload.aspx.cs" Inherits="PrimaryHaul.WebUI.haulier_upload" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpControl" runat="server">
    <div class="form-horizontal">
        <h4>HAULIER Upload</h4>
        <hr />
        <div id="form_import" style="display: ;">
                        <div runat="server" class="form-group">
                <asp:Label runat="server" AssociatedControlID="lnkFile" CssClass="col-md-3 control-label">Week </asp:Label>
                <div class="col-md-9">
                    <asp:Label runat="server" ID="lblWeek" CssClass="form-control" Text="25"></asp:Label>
                </div>
            </div>
            <div runat="server" class="form-group">
                <asp:Label runat="server" AssociatedControlID="lnkFile" CssClass="col-md-3 control-label"></asp:Label>
                <div class="col-md-9">
                    <a runat="server" id="lnkFile" href="file/haulier.xls" target="_blank">file ตัวอย่าง</a>
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
                <div class="col-md-offset-3 col-md-1">
                    <asp:Button runat="server" ID="btnSubmit" Text="Venrify Data" CssClass="btn btn-default" OnClick="btnSubmit_Click" />
                    <p class="text-danger">
                        <asp:Label ID="lblErr" runat="server"></asp:Label>
                    </p>
                </div>
                <div class="col-md-offset-1 col-md-1">
                    <asp:Button runat="server" ID="btnInsert" Text="Insert Data" CssClass="btn btn-default" OnClick="btnInsert_Click" />
                </div>
            </div>
        </div>
        <div id="form_view" style="display: ;">
            <asp:GridView ID="gvData" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" CellSpacing="2">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Haulier_Abbr" HeaderText="Haulier_Abbr" ReadOnly="True" />
                    <asp:BoundField DataField="Po_No" HeaderText="Po_No" ReadOnly="True" />
                    <asp:BoundField DataField="Delivery_Ref" HeaderText="Delivery_Ref" ReadOnly="True" />
                    <asp:BoundField DataField="Delivery_Date" HeaderText="Delivery_Date" ReadOnly="True" />
                    <asp:BoundField DataField="Vendor_Code" HeaderText="Vendor_Code" ReadOnly="True" />
                    <asp:BoundField DataField="Vendor_Name" HeaderText="Vendor_Name" ReadOnly="True" />
                    <asp:BoundField DataField="Collection_Point" HeaderText="Collection_Point" ReadOnly="True" />
                    <asp:BoundField DataField="Delivery_Location" HeaderText="Delivery_Location" ReadOnly="True" />
                    <asp:BoundField DataField="Remark1" HeaderText="Remark1" ReadOnly="True" />
                    <asp:BoundField DataField="Remark2" HeaderText="Remark2" ReadOnly="True" />
                    <asp:BoundField DataField="Fuel_Rate" HeaderText="Fuel_Rate" ReadOnly="True" />
                    <asp:BoundField DataField="Trans_Type" HeaderText="Trans_Type" ReadOnly="True" />

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
