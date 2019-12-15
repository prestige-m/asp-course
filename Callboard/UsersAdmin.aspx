<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMenu.Master" AutoEventWireup="true" CodeBehind="AnnounceAdmin.aspx.cs" Inherits="Callboard.AnnounceAdmin" %>
<%@ Register TagPrefix="usercontrol" TagName="Page404" Src="~/Page404.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <title>Таблиця "Користувачі"</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <% if (Session.Count != 0 && Session["role_id"].ToString()=="1") { %>
        <div class="row justify-content-center">
            <h2 class="title text-center mb-4"></h2>
        </div>
        <div class="row justify-content-center mt-2">
            <h1 class="display-5">Таблиця "Користувачі"</h1>
        </div>

        <div class="row">
        <div class="col-sm-12 col-md-12 col-lg-12">

        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>"
             DeleteCommand="DELETE FROM users WHERE id = @id"
            SelectCommand="SELECT * FROM users">
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
            </DeleteParameters>
        </asp:SqlDataSource>

        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="id"
            AutoGenerateColumns="false" PageSize="4" CssClass="table table-striped table-bordered table-condensed">
             <HeaderStyle CssClass="thead-dark" />
            <RowStyle  />
            <PagerStyle /> 
                <Columns> 
                    <asp:CommandField ShowDeleteButton="True" />
                    <asp:BoundField HeaderText="ID" DataField="id" ReadOnly="True" />
                    <asp:BoundField HeaderText="Електронна адреса" DataField="email" />
                    <asp:BoundField HeaderText="Пароль" DataField="password" />
                    <asp:BoundField HeaderText="Прізвище" DataField="last_name" />
                    <asp:BoundField HeaderText="Ім’я" DataField="first_name" />
                    <asp:BoundField HeaderText="По батькові" DataField="patronymic" />
                    <asp:BoundField HeaderText="Файл зображення" DataField="image_name" />
                    <asp:BoundField HeaderText="Код ролі" DataField="role_id" />
                    <asp:BoundField HeaderText="Код міста" DataField="city_id" />
                    <asp:BoundField HeaderText="Дата створення" DataField="creation_date" />
                </Columns>
        </asp:GridView>
        
    </div>
</div>
    <% } else { %>
        <usercontrol:Page404 id="Page404" runat="server" />    
    <% } %>
</asp:Content>
