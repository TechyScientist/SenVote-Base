<%@ page import="com.johnnyconsole.senvote.persistence.User" %>
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
    <% User user = (User) session.getAttribute("user"); %>
    <h2>Welcome to SenVote, <%= user.getName() %>!</h2>

</div>

<hr/>

</body>
</html>