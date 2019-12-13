<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMenu.Master" AutoEventWireup="true" CodeBehind="IndexAdmin.aspx.cs" Inherits="Callboard.IndexAdmin" %>
<%@ Register TagPrefix="usercontrol" TagName="Page404" Src="~/Page404.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <% if (Session.Count != 0) { %>
<div class="row justify-content-center mt-2">
    <h1 class="display-5">Панель адміністратора</h1>
</div>
<div class="row justify-content-center">
    <div class="col-md-4 col-sm-4 col-lg-4">

        <div class="card">
            <div class="card-header pb-3">
               <strong><%= Session["first_name"].ToString() %></strong>, вам доступні для управління наступні таблиці:
            </div>
             <div class="list-group list-group-flush">
                 <a href="AnnounceAdmin.aspx" class="list-group-item list-group-item-action">Таблиця "Оголошення"</a>
                 <a href="/admin/genre" class="list-group-item list-group-item-action">Таблиця "Категорії"</a>
                 <a href="/admin/publisher" class="list-group-item list-group-item-action">Таблиця "Підкатегорії"</a>
             </div>
    <a href="AnnounceAdmin.aspx">AnnounceAdmin.aspx</a>
        </div>
     </div>
  </div>
 <% } else { %>
        <usercontrol:Page404 id="Page404" runat="server" />    
    <% } %>
</asp:Content>
