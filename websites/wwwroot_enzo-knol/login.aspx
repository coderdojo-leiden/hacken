<% @Page Language="C#" %>

<script runat="server">

    private void Page_Load(object sender, EventArgs e) 
    {
        if(Request.Cookies["Gebruiker"] == null) Response.Cookies["Gebruiker"]["Ingelogd"] = "nee";
        Response.Cookies["Geheim"]["Hint"] = "Hack het cookie 'Gebruiker'!";
    }
    
	private void CheckCredentials(object sender, EventArgs e)
	{
		if(Request.Cookies["Gebruiker"] != null && Request.Cookies["Gebruiker"]["Ingelogd"] == "ja") 
        {
			message.InnerHtml = "Gelukt! Je hebt het cookie gehackt! Het geheime woord is 'Kakatoe'";
			message.Attributes["style"] = "font-weight:bold;font-size:x-large;color:green;";
        }
        else 
        {
            message.InnerHtml = "Gebruikersnaam of wachtwoord is fout!";
			message.Attributes["style"] = "font-weight:bold;font-size:x-large;color:red;";
			ScriptManager.RegisterClientScriptBlock(this, typeof(System.Web.UI.Page), "MyJSFunction", "setTimeout(function() { $('#message').text(''); }, 2000);", true);
        }
	}
</script>

<html>
	<head>
		<title>Login</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	</head>
	<body>
		<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
			<a class="navbar-brand" href="/">Enzo Knol</a>
			</div>
			<ul class="nav navbar-nav">
			<li ><a href="/">Home</a></li>
			<li class="active"><a href="/login.aspx">Login</a></li>
			</ul>
		</div>
		</nav>

		<form id="target" runat="server">
			<table class="table">
					<tr><td><label for="username">Gebruikersnaam</label></td><td><input type="text" id="username" runat="server" /></td></tr>
				<tr><td><label for="password">Wachtwoord</label></td><td><input type="password" id="password" runat="server"/></td></tr>
				<tr><td></td><td><input type="submit" id="button" value="Login" runat="server" OnServerClick="CheckCredentials" class="btn btn-info"/></td></tr>
			</table>
		</form>
		<div runat="server" id="message"></div>
	</body>
</html>