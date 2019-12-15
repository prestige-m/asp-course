
<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMenu.Master" AutoEventWireup="true" CodeBehind="AccountForm.aspx.cs" Inherits="Callboard.AccountForm" %>
<%@ Register TagPrefix="usercontrol" TagName="Page404" Src="~/Page404.ascx" %>

<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <title>Особистий кабінет</title>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <% if (Session.Count != 0) { %>
        <div class="row justify-content-center mt-2">
            <h1 class="display-5">Особистий кабінет</h1>
        </div>

    <div class="row justify-content-center">
      <div class="col-md-4 col-sm-4 col-lg-4" align="center">
        <div>
            <asp:Image ID="Image1" runat="server" CssClass="rounded" style="height:256px; width: 256px;" ImageUrl="~/images/user/default.png" />

              <div class="row justify-content-center py-2">
        		<div align="center" class="col-sm-8 col-md-8 col-lg-8">
                     <asp:FileUpload ID="FileUpload1" runat="server" ValidationGroup="photo" class="form-control" />
        		</div>
              </div>
        		<div class="row justify-content-center py-2">
          			<div align="center" class="col-sm-8 col-md-8 col-lg-8">
                    <asp:Button ID="Button1" runat="server" class="btn btn-secondary btn-block" ValidationGroup="photo"
                         Text="Замінити фото"  OnCommand="UpdateImage" CommandName="update" />
          			</div>
        		</div>
  	   </div>
    </div>
    
  <div class="col-md-8 col-lg-8 col-sm-8">
    <div class="row justify-content-center my-2" ><div id="msg" runat="server" class="col-sm-8 col-md-8 col-lg-8"></div></div>

      <ul class="list-group">
          <li class="list-group-item">
              <div class="row">
                 <div class="col-md-4 col-sm-4 col-lg-4">
                   <strong>Прізвище:</strong>
                 </div>
                 <div class="col-md-7 col-sm-7 col-lg-7">
                     <asp:TextBox ID="last_name" CssClass="form-control" runat="server" required="required"  maxlength="100"></asp:TextBox>
                 </div>
              </div>
           </li>
           <li class="list-group-item">
              <div class="row">
                 <div class="col-md-4 col-sm-4 col-lg-4">
                   <strong>Ім’я:</strong>
                 </div>
                 <div class="col-md-7 col-sm-7 col-lg-7">
                     <asp:TextBox ID="first_name" CssClass="form-control" runat="server" required="required" maxlength="100"></asp:TextBox>
                 </div>
              </div>
           </li> 
           <li class="list-group-item">
              <div class="row">
                 <div class="col-md-4 col-sm-4 col-lg-4">
                   <strong>По батькові:</strong>
                 </div>
                 <div class="col-md-7 col-sm-7 col-lg-7">
                     <asp:TextBox ID="patronymic" CssClass="form-control" runat="server" required="required" maxlength="100"></asp:TextBox>
                 </div>
              </div>
           </li>
           <li class="list-group-item">
              <div class="row">
                 <div class="col-md-4 col-sm-4 col-lg-4">
                   <strong>Електронна адреса:</strong>
                 </div>
                 <div class="col-md-7 col-sm-7 col-lg-7">
                     <asp:TextBox ID="email" CssClass="form-control" runat="server" type="email" required="required" maxlength="100"></asp:TextBox>
                 </div>
              </div>
           </li>
           <li class="list-group-item">
              <div class="row">
                 <div class="col-md-4 col-sm-4 col-lg-4">
                   <strong>Телефон:</strong>
                 </div>
                 <div class="col-md-7 col-sm-7 col-lg-7">
                      <asp:TextBox ID="contact" CssClass="form-control" runat="server"  required="required" pattern="[+]?([0-9]{1,3})?[0-9]{10}"></asp:TextBox>
                 </div>
              </div>
           </li>
          <li class="list-group-item">
              <div class="row">
                 <div class="col-md-4 col-sm-4 col-lg-4">
                   <strong>Місто:</strong>
                 </div>
                 <div class="col-md-7 col-sm-7 col-lg-7">
                     <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
                            SelectCommand="SELECT cities.id as city_id, cities.name as city_name FROM cities"></asp:SqlDataSource>
                     <asp:DropDownList ID="DropDownList1" runat="server" class="form-control" DataSourceID="SqlDataSource1"
                    DataTextField="city_name" DataValueField="city_id"></asp:DropDownList>
                 </div>
              </div>
           </li>

           <li class="list-group-item">
              <div class="row justify-content-center">
                 <div class="col-md-6 col-sm-6 col-lg-6">
                     <asp:Button ID="submit" CssClass="btn btn-outline-primary btn-block" runat="server" Text="Змінити дані" OnClick="UpdateUserInfo" />
                </div>
              </div>
           </li>
        </ul>

    <div class="page-buffer mt-5">
          <div class="row justify-content-center">
              <div class="col-sm-8 col-md-8 col-lg-8">
                  <strong>Змінити пароль:</strong>
              </div>
          </div>
          <div class="row justify-content-center">
              <div class="col-sm-8 col-md-8 col-lg-8">
                  <asp:TextBox ID="TextBox1" runat="server"  ValidationGroup="pass" class="form-control" type="password" maxlength="32" placeholder="Новий пароль"></asp:TextBox>
              </div>
          </div>
          <div class="row justify-content-center">
              <div class="col-sm-8 col-md-8 col-lg-8">
                   <asp:TextBox ID="TextBox2" runat="server"  ValidationGroup="pass" class="form-control mt-3" type="password" maxlength="32" placeholder="Підтвердження паролю"></asp:TextBox>
              </div>
          </div>
          <div class="row justify-content-center mt-3">
              <div class="col-sm-6 col-md-6 col-lg-6">

                  <asp:Button ID="Button2" runat="server" class="btn btn-secondary btn-block" ValidationGroup="pass"
                         Text="Змінити пароль" OnClick="ChangePassword"  />
              </div>
           </div>
    </div>
  </div>

  </div>     
       
     <% } else { %>
        <usercontrol:Page404 id="Page404" runat="server" />    
    <% } %>

</asp:Content>
