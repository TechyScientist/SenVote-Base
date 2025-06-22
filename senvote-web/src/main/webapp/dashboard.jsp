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
    <% if(session.getAttribute("user") == null) response.sendRedirect("index.jsp?error=401 (Unauthorized)&message=You must be signed in to access this page.");
        User user = (User) session.getAttribute("user"); %>
    <h2>Welcome to SenVote, <%= user.name %>! &emsp;&emsp;&emsp; <a href="SignOutServlet" style="display: inline-block;">Sign Out of SenVote</a></h2>

    <a href="votes.jsp">Access Vote List</a>
    <% if(user.accountActive) %> <a href="active-votes.jsp">Open Votes</a>

    <% if(user.accessLevel == 1) { %>
        <h3>SenVote Administration</h3>
        <a href="add-user.jsp">Add a User</a>
        <a href="edit-user.jsp">Edit an Existing User</a>
        <a href="delete-user.jsp">Delete an Existing User</a>
        <a href="create-vote">Create a Vote</a>
        <a href="edit-vote.jsp">Edit an Existing Vote</a>
        <a href="delete-vote.jsp">Delete an Existing Vote</a>

    <% } %>
</div>

<hr/>

</body>
</html>