<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CSC455RecipeManager.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Login</h2>
            <h4>Username</h4>
            <asp:TextBox ID="UsernameBox" runat="server" />
            <h4>Password</h4>
            <asp:TextBox ID="PasswordBox" runat="server" />
            <br /> <br />
            <asp:Button runat="server" Text="Sign In" OnClick="SignInButton_Clicked" />
            <asp:Button runat="server" Text="Cancel" OnClick="CancelSignInButton_Clicked" />
            <br />
            <asp:Label ID="ResultLabel" runat="server" Visible="False"></asp:Label>
        </div>
    </form>
</body>
</html>
