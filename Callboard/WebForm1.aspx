<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMenu.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Callboard.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="modal   " id="sample_modal" role="dialog" tabindex="-1" >
<div class="modal-dialog ">
<asp:UpdatePanel ID="UpdatePanel2" runat="server" EnableViewState="true">
<ContentTemplate>
        <div class=" modal-content">
        <div class="modal-header">Modal Heading</div>
        <div class="modal-body col-sm-12">
        <div class="form-group ">
        <label class="col-sm-4 control-label">New Category</label>
        <div class="col-sm-8">
        <asp:TextBox ID="txtCat" CssClass="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfv1" CssClass="alert-danger" ControlToValidate="txtCat" ValidationGroup="save-modal" SetFocusOnError="true" Display="Dynamic" runat="server" 
            ErrorMessage="Please Enter category!!!"></asp:RequiredFieldValidator>
        </div>
        </div>
        </div>
        <div class="modal-footer">
        <asp:Button ID="btn_save" runat="server" CssClass="btn btn-primary" Text="Add" OnClick="btn_save_Click" ValidationGroup="save-modal"   />
        <button type="button" class="btn btn-default pull-right" data-dismiss="modal">Close</button>
        </div>
        </div>
</ContentTemplate>
</asp:UpdatePanel>
</div>
</div>

    <button type="button" id="btn_open_modal" class="btn btn-primary btn-lg ">Add New Category</button>
</asp:Content>
