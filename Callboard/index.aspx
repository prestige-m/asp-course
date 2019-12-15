<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMenu.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Callboard.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Головна сторінка</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:SqlDataSource ID="CategoryData" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
        SelectCommand="SELECT categories.id as category_id, categories.name as category_name FROM categories;"></asp:SqlDataSource>

    <div class="row">

 <div class="col-sm-3 col-md-3 col-lg-3">
    <asp:Repeater id="RepeaterMenu" runat="server" DataSourceID="CategoryData">
        <HeaderTemplate>
          <div class="card">
            <div class="card-header"><h5><strong>Категорії об’яв</strong></h5></div>
               <div class="list-group list-group-flush">
        </HeaderTemplate>
        <ItemTemplate>
            <a href='<%#string.Format("index.aspx?search_by_category_id={0}", Eval("category_id"))%>' class="menu-item list-group-item list-group-item-action">
                <%#DataBinder.Eval(Container.DataItem, "category_name") %>
            </a>
        </ItemTemplate>
        <FooterTemplate>
              </div>
          </div>
       </FooterTemplate>
</asp:Repeater>
</div>

    <div class="col-sm-9 col-md-9 col-lg-9">
    <div class="row justify-content-center my-3">
          <div class="col-sm-7 col-md-7 col-lg-7">
              <asp:TextBox ID="Search" runat="server" class="form-control" aria-label="Search"></asp:TextBox>
          </div>
           <div class="col-sm-2 col-md-2 col-lg-2">
               <asp:Button ID="Button3" runat="server" Text="Пошук" class="btn btn-outline-success btn-block my-2 my-sm-0" type="submit" OnClick="Button3_Click"/>
          </div> 
        </div>


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
                               <div class="col-sm-12 col-md-12 col-lg-12 text-truncate">
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
          </ItemTemplate>
                     
       </asp:Repeater>
</div>
</div>


</asp:Content>
