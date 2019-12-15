<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMenu.Master" AutoEventWireup="true" CodeBehind="MyAnnouncements.aspx.cs" Inherits="Callboard.MyAnnouncements" %>
<%@ Register TagPrefix="usercontrol" TagName="Page404" Src="~/Page404.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <title>Мої оголошення</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <% if (Session.Count != 0) { %>
    <asp:SqlDataSource ID="AnnounceData" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
        SelectCommand="SELECT announcements.id as id, title, user_id, announcements.subcategory_id as subcategory_id, subcategories.name as subcategory_name,
                        categories.name as category_name, categories.id as category_id,
                        city_id, image_name, cities.name as city_name, regions.name as region_name, creation_date, message_text, price FROM announcements
                        INNER JOIN subcategories ON subcategories.id = announcements.subcategory_id
                        INNER JOIN categories ON subcategories.category_id = categories.id
                        INNER JOIN cities ON cities.id = announcements.city_id
                        INNER JOIN regions ON regions.id = cities.region_id"></asp:SqlDataSource>
    <asp:SqlDataSource ID="CategoryData" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
        SelectCommand="SELECT categories.id as category_id, categories.name as category_name FROM categories;"></asp:SqlDataSource>

   <div class="row justify-content-center my-2" ><div id="msg" runat="server" class="col-sm-8 col-md-8 col-lg-6"></div></div>

 <div class="row justify-content-center">
    <div class="col-sm-9 col-md-9 col-lg-9">

         <% if ( this.announcements.Tables[0].Rows.Count == 0) {%>
        <div class="row justify-content-center">
           <div class="col-sm-9 col-md-9 col-lg-9 my-2">
                 На жаль нічого не знайдено. <i class="far fa-frown-open"></i>
           </div>
        </div>
        <%} %>

       <asp:Repeater id="RepeaterItems" runat="server">
          <ItemTemplate> 
            <div class="link-box">
              <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# string.Format("AnnouceView.aspx?announce_id={0}", Eval("id")) %>'></asp:HyperLink>
              <div class="row justify-content-center">
                  <div class="img-container col-sm-9 col-md-9 col-lg-9 rounded my-2">
                      <div class="row">
                         <asp:Image ID="ItemImage" runat="server" CssClass="img-item my-3" ImageUrl='<%# string.Format("~/images/{0}", Eval("image_name")) %>' />
                        <div class="col-sm-12 col-md-7 col-lg-7">
                           <div class="row pt-2">
                               <div class="col-sm-9 col-md-9 col-lg-9 text-truncate">
                                    <asp:Label runat="server" ID="ItemTitle" CssClass="title" Text='<%#DataBinder.Eval(Container.DataItem, "title") %>' ></asp:Label>
                               </div> 
                               
                           </div>
                            <div class="row py-3">
                                <div class="col-sm-12 col-md-12 col-lg-12">
                                    <asp:Label runat="server" ID="Label1" CssClass="m-price" Text='<%# (Eval("price").ToString() != "")? string.Format("{0} грн.", Eval("price")) : "   " %>'></asp:Label>
                               </div>    
                           </div>
                            <div class="row pt-2">
                                <div class="col-sm-12 col-md-12 col-lg-12">
                                     <div class="float-left">
                                        <asp:Label runat="server" ID="Label2" class="m-attr" Text='<%#DataBinder.Eval(Container.DataItem, "category_name") %>' ></asp:Label>
                                    </div>
                                     <div class="float-left">
                                        <asp:Label runat="server" ID="Label4" class="m-attr-next" Text='<%#DataBinder.Eval(Container.DataItem, "subcategory_name") %>' ></asp:Label>
                                    </div>
                                </div>
                                
                           </div>
                            <div class="row pt-2">
                                <div class="col-sm-6 col-md-6 col-lg-6">
                                    <i class="far fa-clock"></i>
                                    <asp:Label runat="server" ID="Label3" class="m-attr" Text='<%#DataBinder.Eval(Container.DataItem, "creation_date") %>' ></asp:Label>
                                </div>
                                <div class="col-sm-6 col-md-6 col-lg-6 text-truncate">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <asp:Label runat="server" ID="Label5" class="m-attr" Text='<%#DataBinder.Eval(Container.DataItem, "city_name") %>' ></asp:Label>
                                </div>
                           </div>
                        </div>
                      </div>
                  </div>
              </div>
            </div>

              <div class="row justify-content-center mb-4">
                  <div class="col-sm-3 col-md-3 col-lg-3 float-right">
                      <asp:HyperLink ID="HyperLink2" runat="server" CssClass="btn btn-success btn-block" NavigateUrl='<%# string.Format("~/UpdateAnnouncement.aspx?id={0}", Eval("id")) %>'>
                            Редагувати <i class="fas fa-pencil-alt"></i> 
                       </asp:HyperLink>
                   </div>
                  <div class="col-sm-3 col-md-3 col-lg-3 float-left">
                      <asp:HyperLink ID="HyperLink3" runat="server" CssClass="btn btn-danger btn-block" NavigateUrl='<%# string.Format("~/MyAnnouncements.aspx?delete_id={0}", Eval("id")) %>'>
                             Видалити <i class="fas fa-times"></i> 
                       </asp:HyperLink>
                   </div>
              </div>

          </ItemTemplate>
                     
       </asp:Repeater>
</div>
</div>
        <% } else { %>
        <usercontrol:Page404 id="Page404" runat="server" />    
    <% } %>

</asp:Content>
