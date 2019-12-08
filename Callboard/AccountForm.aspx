
<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMenu.Master" AutoEventWireup="true" CodeBehind="AccountForm.aspx.cs" Inherits="Callboard.AccountForm" %>
<%@ Register TagPrefix="usercontrol" TagName="Page404" Src="~/Page404.ascx" %>

<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <title>Особистий кабінет</title>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <% if (Session.Count != 0) { %>
        <div class="row justify-content-center my-margin-top-10 my-padding-top-1">
            <h1 class="display-4">Особистий кабінет</h1>
        </div>

       
         <div class="row">
            <div class="col-md-4 offset-md-4 mt-3">
                <asp:TextBox ID="first_name" CssClass="form-control" runat="server" required="required" minlength="2" maxlength="100"></asp:TextBox>
            </div>
        </div>
         <div class="row">
            <div class="col-md-4 offset-md-4 mt-3">
                <asp:TextBox ID="last_name" CssClass="form-control" runat="server" required="required"  minlength="2" maxlength="100"></asp:TextBox>
            </div>
        </div>
         <div class="row">
            <div class="col-md-4 offset-md-4 mt-3">
                <asp:TextBox ID="patronymic" CssClass="form-control" runat="server" required="required" minlength="2" maxlength="100"></asp:TextBox>
            </div>
        </div>
        <div class="row">
           <div class="col-md-4 offset-md-4 mt-3">
                <asp:TextBox ID="email" CssClass="form-control" runat="server" type="email" required="required" minlength="4" maxlength="128"></asp:TextBox>
           </div>
        </div>
         <div class="row">
            <div class="col-md-4 offset-md-4 mt-3">
                <asp:TextBox ID="contact" CssClass="form-control" runat="server"  required="required" Rows="2" TextMode="MultiLine"></asp:TextBox>
            </div>
        </div>


       <div class="row justify-content-center">
            <div class="col-6 col-md-2 mt-3">
                <asp:Button ID="submit" CssClass="btn btn-outline-dark btn-block" runat="server" Text="Зберегти" OnClick="UpdateUserInfo" />
            </div>
        </div>


    <% } else { %>
        <usercontrol:Page404 id="Page404" runat="server" />    
    <% } %>
</asp:Content>
