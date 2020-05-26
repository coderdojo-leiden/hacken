<% @Page Language="C#" %>
<%@ Import Namespace="Finisar.SQLite" %> 

<script runat="server">
	private void CheckCredentials(object sender, EventArgs e)
	{
		SQLiteConnection sqlite_conn = new SQLiteConnection ("Data Source=" + Server.MapPath("~") + "\\App_Data\\DemoT.db;Version=3;New=False;Compress=True;"); 
		sqlite_conn.Open(); 
		SQLiteCommand sqlite_cmd = sqlite_conn.CreateCommand(); 

		//  hacken door 2x in te vullen  ' or ''='
		// of gewoon 1 keer ' or 1=1 --
		string cmdText = "select * from users where username='" + username.Value + "' and password='" + password.Value + "'"; 
        
        if (!cmdText.ToUpper().Contains("DROP")) 
        { 
    		sqlite_cmd.CommandText = cmdText;
    		SQLiteDataReader sqlite_datareader=sqlite_cmd.ExecuteReader();
    		if (sqlite_datareader.Read()) // Read() returns true if there is still a result line to read
    		{
    			message.InnerHtml = "Gelukt! Je hebt de site gehackt! Het geheime woord is 'Pepernoot-boot'";
    			message.Attributes["style"] = "font-weight:bold;font-size:x-large;color:green;";
    		}
    		else 
			{
    		    message.InnerHtml = "Gebruikersnaam of wachtwoord is fout!";
				message.Attributes["style"] = "font-weight:bold;font-size:x-large;color:red;";
				ScriptManager.RegisterClientScriptBlock(this, typeof(System.Web.UI.Page), "MyJSFunction", "setTimeout(function() { $('#message').text(''); }, 2000);", true);
    		}
        } else 
		{
            message.InnerHtml = "Gebruikersnaam of wachtwoord is fout!";
			message.Attributes["style"] = "font-weight:bold;font-size:x-large;color:red;";
			ScriptManager.RegisterClientScriptBlock(this, typeof(System.Web.UI.Page), "MyJSFunction", "setTimeout(function() { $('#message').text(''); }, 2000);", true);
        }


		//SQLiteCommand sqlite_cmd = sqlite_conn.CreateCommand(); 
		//sqlite_cmd.CommandText = "CREATE TABLE users (id integer primary key, username varchar(100), password varchar(100));";
		//sqlite_cmd.ExecuteNonQuery();
		//sqlite_cmd.CommandText = "INSERT INTO users (id, username, password) VALUES (1, 'admin', 'telefax123');";
		//sqlite_cmd.ExecuteNonQuery();
			
		sqlite_conn.Close();
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
			<a class="navbar-brand" href="/">Eva Jinek</a>
			</div>
			<ul class="nav navbar-nav">
			<li ><a href="/">Home</a></li>
			<li class="active"><a href="/admin.aspx">Admin</a></li>
			</ul>
		</div>
		</nav>

		<div class="alert alert-info">
			<strong>Hackers hebben pech!</strong> Deze website controleert wachtwoorden in SQL, en is dus super veilig
		</div>

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