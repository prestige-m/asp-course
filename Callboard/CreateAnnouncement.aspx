<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMenu.Master" AutoEventWireup="true" CodeBehind="CreateAnnouncement.aspx.cs" Inherits="Callboard.CreateAnnouncement" EnableEventValidation="false" %>
<%@ Register TagPrefix="usercontrol" TagName="Page404" Src="~/Page404.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Створити оголошення</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
    <div class="row justify-content-center my-2" ><div id="msg" runat="server" class="col-sm-8 col-md-8 col-lg-6"></div></div>

    <% if (Session.Count != 0) { %>


     <div class="row justify-content-center mt-2">
            <h1 class="display-5">Створити оголошення</h1>
     </div>

    <div class="row justify-content-center my-4">
        <ul class="list-group">
           <li class="list-group-item">
              <div class="row">
                 <div class="col-md-4 col-sm-4 col-lg-4">
                   <strong>Заловок оголошення</strong>
                 </div>
                 <div class="col-md-8 col-sm-8 col-lg-8">
                     <asp:TextBox ID="TextBox1" runat="server" required class="form-control"></asp:TextBox>
                 </div>
              </div>
           </li>
           <li class="list-group-item">
              <div class="row">
                 <div class="col-md-4 col-sm-4 col-lg-4">
                   <strong>Категорія / Підкатегорія:</strong>
                 </div>
                 <div class="col-md-8 col-sm-8 col-lg-8">
                     <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
                                 SelectCommand="SELECT categories.id as category_id, categories.name as category_name FROM categories"
                                 EnableCaching="True" CacheDuration="20"></asp:SqlDataSource>
                      <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
                                 SelectCommand="SELECT id as subcategory_id, name as subcategory_name, category_id FROM subcategories" 
                                 FilterExpression="category_id='{0}'" EnableCaching="true">
                           <FilterParameters>
                                <asp:ControlParameter ControlID="DropDownList1" Name="sub_id" PropertyName="SelectedValue" />
                           </FilterParameters>
                      </asp:SqlDataSource>
                     <asp:DropDownList ID="DropDownList1" runat="server" class="form-control" AutoPostBack="true" DataSourceID="SqlDataSource1"
                         DataTextField="category_name" DataValueField="category_id"></asp:DropDownList>
                     <asp:DropDownList ID="DropDownList2" runat="server" class="form-control" DataSourceID="SqlDataSource2"
                         DataTextField="subcategory_name" DataValueField="subcategory_id"></asp:DropDownList>
                 </div>
              </div>
           </li>
           
            <li class="list-group-item">
              <div class="row">
                 <div class="col-md-4 col-sm-4 col-lg-4">
                   <strong>Текст оголошення:</strong>
                 </div>
                 <div class="col-md-8 col-sm-8 col-lg-8">
                     <asp:TextBox ID="TextBox2" required CssClass="form-control" runat="server" Rows="5" TextMode="MultiLine"></asp:TextBox>
                 </div>
              </div>
           </li>
            <li class="list-group-item">
              <div class="row">
                 <div class="col-md-4 col-sm-4 col-lg-4">
                   <strong>Ціна:</strong>
                 </div>
                 <div class="col-md-8 col-sm-8 col-lg-8">
                     <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" pattern="[0-9]*([.,][0-9]{1,2})?"></asp:TextBox>
                 </div>
              </div>
           </li>
           <li class="list-group-item">
              <div class="row">
                 <div class="col-md-4 col-sm-4 col-lg-4">
                   <strong>Файл зображення:</strong>
                 </div>
                 <div class="col-md-8 col-sm-8 col-lg-8">
                     <asp:FileUpload ID="FileUpload1" runat="server" class="form-control" />
                 </div>
              </div>
           </li>
           
           <li class="list-group-item">
              <div class="row justify-content-center">
                 <div class="col-md-6 col-sm-6 col-lg-6">
                     <asp:Button ID="Button1" runat="server" Text="Додати оголошення" class="btn btn-outline-dark btn-block" OnClick="Button1_Click"/>
                </div>
              </div>
           </li>
        </ul>
   
    </div>
     <% } else { %>
        <usercontrol:Page404 id="Page404" runat="server" />    
    <% } %>

</asp:Content>
