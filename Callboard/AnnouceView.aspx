<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMenu.Master" AutoEventWireup="true" CodeBehind="AnnouceView.aspx.cs" Inherits="Callboard.AnnouceView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-2">
  <div class="row justify-content-center">
     <div class="col-sm-8 col-md-8 col-lg-8">

       <div class="card">
             <asp:Image ID="Image1" runat="server" CssClass="card-img-top" ImageUrl="~/images/1.jpg" />
           <div class="card-body">
               <h5 class="card-title"><asp:Label ID="Label1" runat="server" Text=""></asp:Label></h5>
               <p class="card-text text-muted"><asp:Label ID="Label2" runat="server" Text=""></asp:Label></p>
               <p class="card-text">
                   <asp:Image ID="Image2" runat="server" CssClass="avatar" ImageUrl="~/images/user/default.png"/>
                   <asp:Label ID="Label3" runat="server" Text=""></asp:Label>
               </p>
                <p class="card-text"><asp:Label ID="Label4" runat="server" Text=""></asp:Label></p>
           </div>
            <div class="card-footer">
                <small class="text-muted"><asp:Label ID="Label5" runat="server" Text=""></asp:Label> </small>
            </div>
       </div>
      <div class="row justify-content-center my-3">
        <div class="col-sm-6 col-md-6 col-lg-6">
            <asp:HyperLink ID="HyperLink2" runat="server" class="btn btn-block btn-dark" NavigateUrl="~/index.aspx">Назад</asp:HyperLink>
        </div>
      </div>
      
   </div>
</div>

</asp:Content>
