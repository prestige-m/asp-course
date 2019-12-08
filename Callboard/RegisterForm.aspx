<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMenu.Master" AutoEventWireup="true" CodeBehind="RegisterForm.aspx.cs" Inherits="Callboard.RegisterForm" %>
<%@ Register TagPrefix="usercontrol" TagName="Page404" Src="~/Page404.ascx" %>

<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <title>Реєстрація</title>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <% if (Session.Count == 0) { %>
        <div class="row justify-content-center mt-2">
            <h1 class="display-5">Реєстрацiя</h1>
        </div>
        <div class="row">
            <div class="col-md-4 offset-md-4 mt-3">
                <asp:TextBox ID="email" CssClass="form-control" runat="server" type="email" required="required" placeholder="Електронна адреса" minlength="4" maxlength="128"></asp:TextBox>
            </div>
        </div>
         <div class="row">
            <div class="col-md-4 offset-md-4 mt-3">
                <asp:TextBox ID="password" CssClass="form-control" runat="server" type="password" required="required" placeholder="Пароль" minlength="4" maxlength="128"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 offset-md-4 mt-3">
                <asp:TextBox ID="password_repeat" CssClass="form-control" runat="server" type="password" required="required" placeholder="Повторіть пароль" minlength="4" maxlength="128"></asp:TextBox>
            </div>
        </div>
         <div class="row">
            <div class="col-md-4 offset-md-4 mt-3">
                <asp:TextBox ID="first_name" CssClass="form-control" runat="server" required="required" placeholder="Ім’я" minlength="2" maxlength="100"></asp:TextBox>
            </div>
        </div>
         <div class="row">
            <div class="col-md-4 offset-md-4 mt-3">
                <asp:TextBox ID="last_name" CssClass="form-control" runat="server" required="required" placeholder="Прізвище" minlength="2" maxlength="100"></asp:TextBox>
            </div>
        </div>
         <div class="row">
            <div class="col-md-4 offset-md-4 mt-3">
                <asp:TextBox ID="patronymic" CssClass="form-control" runat="server" required="required" placeholder="По батькові" minlength="2" maxlength="100"></asp:TextBox>
            </div>
        </div>
         <div class="row">
            <div class="col-md-4 offset-md-4 mt-3">
                <asp:TextBox ID="contact" CssClass="form-control" runat="server"  required="required" placeholder="Контактна інформація" Rows="2" TextMode="MultiLine"></asp:TextBox>
            </div>
        </div>

        <div class="row justify-content-center my-container">
            <div class="col-12 col-md-4" align="center">
                <asp:Label CssClass="text-danger" ID="errors" runat="server"></asp:Label>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class="col-md-4 col-xs-12 my-margin-top-10">
                <asp:Button ID="submit" CssClass="btn btn-outline-dark btn-block" runat="server" Text="Зареєструватись" OnClick="Registration" />
            </div>
        </div>
    <% } else { %>
        <usercontrol:Page404 id="Page404" runat="server" />    
    <% } %>
</asp:Content>
