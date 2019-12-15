<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMenu.Master" AutoEventWireup="true" CodeBehind="AnnounceAdmin.aspx.cs" Inherits="Callboard.AnnounceAdmin" %>
<%@ Register TagPrefix="usercontrol" TagName="Page404" Src="~/Page404.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Таблиця "Оголошення"</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <% if (Session.Count != 0 && Session["role_id"].ToString()=="1") { %>
        <div class="row justify-content-center">
            <h2 class="title text-center mb-4"></h2>
        </div>
        <div class="row justify-content-center mt-2">
            <h1 class="display-5">Таблиця "Оголошення"</h1>
        </div>

        <div class="row">
        <div class="col-sm-12 col-md-12 col-lg-12">

        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>"
             DeleteCommand="DELETE FROM announcements WHERE id = @id"
            UpdateCommand="Update announcements SET title=@title, user_id=@user_id, subcategory_id=@subcategory_id,
            image_name=@image_name, creation_date=@creation_date, message_text=@message_text, price=@price WHERE id=@id"
          
            SelectCommand="SELECT * FROM announcements">
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="title" Type="String" />
                <asp:Parameter Name="user_id" Type="Int32" />
                <asp:Parameter Name="subcategory_id" Type="Int32" />
                <asp:Parameter Name="city_id" Type="Int32" />
                <asp:Parameter Name="image_name" Type="String" />
                <asp:Parameter Name="creation_date" Type="DateTime" />
                <asp:Parameter Name="message_text" Type="String" />
                <asp:Parameter Name="price" Type="Decimal" />
                <asp:Parameter Name="id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>


        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="id"
            AutoGenerateColumns="false" PageSize="4" CssClass="table table-striped table-bordered table-condensed">
             <HeaderStyle CssClass="thead-dark" />
            <RowStyle  />
            <PagerStyle /> 
                <Columns>
                    <asp:TemplateField HeaderText="">  
                        <ItemTemplate> 
                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#Eval("id","~/UpdateAnnouncement.aspx?id={0}") %>'>Змінити</asp:HyperLink>
                        </ItemTemplate>  
                   </asp:TemplateField>  
                    <asp:CommandField ShowDeleteButton="True" />
                    <asp:BoundField HeaderText="ID" DataField="id" ReadOnly="True" />
                    <asp:BoundField HeaderText="Назва" DataField="title" />
                    <asp:BoundField HeaderText="Код користувача" DataField="user_id" />
                    <asp:BoundField HeaderText="Код підкатегорії" DataField="subcategory_id" />
                    <asp:BoundField HeaderText="Назва зображення" DataField="image_name" />
                    <asp:BoundField HeaderText="Час створення" DataField="creation_date" />
                    <asp:BoundField HeaderText="Текст оголошення" DataField="message_text" />
                    <asp:BoundField HeaderText="Ціна" DataField="price" />
                </Columns>
        </asp:GridView>
        
    </div>
</div>
    <% } else { %>
        <usercontrol:Page404 id="Page404" runat="server" />    
    <% } %>
</asp:Content>
