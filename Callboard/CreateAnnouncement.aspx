<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMenu.Master" AutoEventWireup="true" CodeBehind="CreateAnnouncement.aspx.cs" Inherits="Callboard.CreateAnnouncement" Async="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:SqlDataSource ID="AnnounceData" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
        SelectCommand="SELECT announcements.id as id, title, user_id, announcements.subcategory_id as subcategory_id, subcategories.name as subcategory_name,
                        categories.name as category_name, categories.id as category_id,
                        city_id, image_name, cities.name as city_name, regions.name as region_name, creation_date, message_text, price FROM announcements
                        INNER JOIN subcategories ON subcategories.id = announcements.subcategory_id
                        INNER JOIN categories ON subcategories.category_id = categories.id
                        INNER JOIN cities ON cities.id = announcements.city_id
                        INNER JOIN regions ON regions.id = cities.region_id"></asp:SqlDataSource>
   
    <div class="row justify-content-center my-4">
        <ul class="list-group">
           <li class="list-group-item">
              <div class="row">
                 <div class="col-md-4 col-sm-4 col-lg-4">
                   <strong>Заловок оголошення</strong>
                 </div>
                 <div class="col-md-8 col-sm-8 col-lg-8">
                     <asp:TextBox ID="AnnounceTitle" runat="server" required class="form-control"></asp:TextBox>
                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Заповніть поле 'Заголовок'" ControlToValidate="AnnounceTitle"></asp:RequiredFieldValidator>
               --%>  </div>
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
                         DataTextField="category_name" DataValueField="category_id" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"></asp:DropDownList>
                     <asp:DropDownList ID="DropDownList2" runat="server" class="form-control" DataSourceID="SqlDataSource2"
                         DataTextField="subcategory_name" DataValueField="subcategory_id"></asp:DropDownList>
                 </div>
              </div>
           </li>
           <li class="list-group-item">
              <div class="row">
                 <div class="col-md-4 col-sm-4 col-lg-4">
                   <strong>Область / Місто:</strong>
                 </div>
                 <div class="col-md-8 col-sm-8 col-lg-8">
                     <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
                                 SelectCommand="SELECT regions.id as region_id, regions.name as region_name FROM regions"
                                 EnableCaching="True" CacheDuration="20"></asp:SqlDataSource>
                           <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
                                 SelectCommand="SELECT id as city_id, name as city_name, region_id FROM cities"
                                 FilterExpression="region_id='{0}'" EnableCaching="true">
                          <FilterParameters>
                              <asp:ControlParameter ControlID="DropDownList3" Name="region_id" PropertyName="SelectedValue" />
                          </FilterParameters>
                      </asp:SqlDataSource>
                     <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="true" class="form-control" DataSourceID="SqlDataSource3"
                         DataTextField="region_name" DataValueField="region_id" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged"></asp:DropDownList>
                     <asp:DropDownList ID="DropDownList4" class="form-control" runat="server"  DataSourceID="SqlDataSource4"
                         DataTextField="city_name" DataValueField="city_id"></asp:DropDownList>
                 </div>
              </div>
           </li>
            <li class="list-group-item">
              <div class="row">
                 <div class="col-md-4 col-sm-4 col-lg-4">
                   <strong>Текст оголошення:</strong>
                 </div>
                 <div class="col-md-8 col-sm-8 col-lg-8">
                     <asp:TextBox ID="TextBox1" required CssClass="form-control" runat="server" Rows="5" TextMode="MultiLine"></asp:TextBox>
                 </div>
              </div>
           </li>
            <li class="list-group-item">
              <div class="row">
                 <div class="col-md-4 col-sm-4 col-lg-4">
                   <strong>Ціна:</strong>
                 </div>
                 <div class="col-md-8 col-sm-8 col-lg-8">
                     <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" pattern="[0-9]*([.,][0-9]{1,2})?"></asp:TextBox>
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
                     <asp:Button ID="Button1" runat="server" Text="Додати оголошення" class="btn btn-outline-dark btn-block"/>
                </div>
              </div>
           </li>
        </ul>
   
    </div>


</asp:Content>
