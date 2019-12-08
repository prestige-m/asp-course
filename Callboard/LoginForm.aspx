<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMenu.Master" AutoEventWireup="true" CodeBehind="LoginForm.aspx.cs" Inherits="Callboard.LoginForm" %>
<%@ Register TagPrefix="usercontrol" TagName="Page404" Src="~/Page404.ascx" %>

<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <title>Вхід</title>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <% if (Session.Count == 0) { %>

         <div class="row justify-content-center mt-2">
            <h1 class="display-5">Вхід</h1>
        </div>
        <div class="row justify-content-center">
            <div class="col-12 col-md-5 mt-3">
                <asp:TextBox ID="email" CssClass="form-control" runat="server" required="required" type="email" placeholder="Електронна адреса користувача"></asp:TextBox>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class="col-12 col-md-5 mt-3">
                <asp:TextBox ID="password" CssClass="form-control" runat="server" type="password" required="required" placeholder="Пароль"></asp:TextBox>
            </div>
        </div>
        <div class="row justify-content-center my-container">
            <div class="col-12 col-md-4" align="center">
                <asp:Label CssClass="text-danger" ID="errors" runat="server"></asp:Label>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class="col-6 col-md-2 mt-3">
                <asp:Button ID="submit" CssClass="btn btn-outline-dark btn-block" runat="server" Text="Увійти" OnClick="Login" />
            </div>
        </div>
    <% } else { %>
        <usercontrol:Page404 id="Page404" runat="server" />    
    <% } %>
</asp:Content>