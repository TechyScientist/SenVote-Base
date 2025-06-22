<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SenVote Web</title>
    <link rel="stylesheet" href="assets/style/main.css" />
</head>
<body>
<div id="header">
    <h1>SenVote Web</h1>
</div>
<div id="body">
    <% if(session.getAttribute("user") != null) response.sendRedirect("dashboard.jsp");
        if(request.getParameter("error") != null && request.getParameter("message") != null) { %>
        <p id="error"><strong>Error <%= request.getParameter("error") %></strong>: <%= request.getParameter("message") %></p>
    <% } %>
    <h2>Sign In</h2>
    <p>Welcome to SenVote Web! Please sign in to your SenVote account to continue.</p>
    <form action="SignInServlet" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" placeholder="Username" required/><br/><br/>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" placeholder="Password" required/><br/><br/>
        <input type="submit" name="senvote-signin-submit" value="Sign In" />
    </form>
</div>

<hr/>

</body>
</html>