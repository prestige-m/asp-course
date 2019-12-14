<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMenu.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Callboard.WebForm1" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
        <Services>
            <asp:ServiceReference Path="~/CityService.asmx" />
        </Services>
    </asp:ScriptManager>

Your Name : 
<asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
<input id="btnGetTime" type="button" value="Show Current Time" onclick="GetCities(this.value);" />

  <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
                                 SelectCommand="SELECT regions.id as region_id, regions.name as region_name FROM regions"
                                 ></asp:SqlDataSource>

                     <asp:DropDownList ID="DropDownList3" runat="server" class="form-control target" DataSourceID="SqlDataSource3"
                         DataTextField="region_name" DataValueField="region_id" onchange="GetCities(this.value);"></asp:DropDownList>
                     <asp:DropDownList ID="DropDownList4" class="form-control container_list" runat="server"
                         DataTextField="city_name" DataValueField="city_id"  onchange="SetChange(this.value);"></asp:DropDownList>


</asp:Content>

