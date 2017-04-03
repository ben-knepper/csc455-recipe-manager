<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CSC455RecipeManager._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <p class="lead">&nbsp;</p>
        <p class="lead">
            <img alt="" src="file:///C:/Users/Rachel/Source/Repos/NewRepo/CSC455RecipeManager/Pictures/Ingredients-1024x683.jpg" style="width: 954px; height: 371px" /></p>
        <p class="lead" style="text-align: center">Details about CSC455 Recipe Manager</p>
        <p>CSC455 is an website desgined to help organize the ingredients that are in your pantry. By creating an account you will be able to save all of your ingredients then based on those ingredients be able to see what dishes can be prepared. Also the website will let the user know if they are low on an ingredient and print out a detailed list describing what the user needs to buy from the grocery store.</p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2 class="text-center">Shopping Lists</h2>
            <p>
                Every account comes with the ability to let the user know when he/she is out of a certain ingredients.</p>
            <p>
                The grocery list is one click away when you login to your account. Just click the grocery list button and be shown a list which will show you ingredients that are low in your pantry.</p>
        </div>
        <div class="col-md-4">
            <h2 class="text-center">Dish Creation</h2>
            <p>
                When you start inputting ingredients into CSC455 Recipe Manager, the system automatically starts comparing your ingredients to ingredients in every dish. Whenever you have enough ingredients to create a dish you can see a detailed list of all of the ingredients needed to make this dish.
            </p>
            <p>
                &nbsp;</p>
        </div>
        <div class="col-md-4">
            <h2>Web Hosting</h2>
            <p>
                You can easily find a web hosting company that offers the right mix of features and price for your applications.
            </p>
            <p>
                <a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301950">Learn more &raquo;</a>
            </p>
        </div>
    </div>

    <div>
        <h2>Login</h2>
        <a href="Login.aspx">Click Here</a>
    </div>

</asp:Content>
