<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMenu.Master" AutoEventWireup="true" CodeBehind="AnnounceAdmin.aspx.cs" Inherits="Callboard.AnnounceAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    
    <div class="container">
        <div class="row justify-content-center">
            <h2 class="title text-center mb-4">Таблиця "Книги"</h2>
        </div>
        <div class="row">
            <nav aria-label="breadcrumb">
              <ol class="breadcrumb">
                  <li class="breadcrumb-item"><a href="/admin">Адмін-панель</a></li>
                  <li class="breadcrumb-item active" aria-current="page">Таблиця "Книги"</li>
              </ol>
            </nav>
            <a href="/admin/book/create" class="btn btn-default ml-3"><i class="fas fa-plus"></i> <strong>Додати книгу</strong></a>
        </div>

        <div class="row">


        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
            SelectCommand="SELECT * FROM announcements"></asp:SqlDataSource>

        <asp:GridView ID="gridEmployees" runat="server" DataSourceID="SqlDataSource1"
            AutoGenerateColumns="false" PageSize="4" CssClass="table table-striped table-bordered table-condensed">
             <HeaderStyle CssClass="thead-dark" />
            <RowStyle  />
            <PagerStyle /> 
                <Columns>
                    <asp:BoundField HeaderText="ID" DataField="id" />
                    <asp:BoundField HeaderText="Назва" DataField="title" />
                    <asp:BoundField HeaderText="Код користувача" DataField="user_id" />
                    <asp:BoundField HeaderText="Код підкатегорії" DataField="subcategory_id" />
                    <asp:BoundField HeaderText="Код міста" DataField="city_id" />
                    <asp:BoundField HeaderText="Назва зображення" DataField="image_name" />
                    <asp:BoundField HeaderText="Час створення" DataField="creation_date" />
                    <asp:BoundField HeaderText="Текст оголошення" DataField="message_text" />
                    <asp:BoundField HeaderText="Ціна" DataField="price" />
                </Columns>
        </asp:GridView>


        </div>
    </div>
</asp:Content>
