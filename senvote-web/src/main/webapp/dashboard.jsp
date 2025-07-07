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
        User user = (User) session.getAttribute("user");
        if(!user.accountActive) { %>
            <p id="warning"><strong>Warning:</strong> Your account is labelled as <strong>inactive</strong>. You will not be able to participate in any active divisions<% if(user.accessLevel == 1) { %> or perform any administrator functions<% } %>.</p>
     <% }
         if(request.getParameter("error") != null && request.getParameter("message") != null) { %>
            <p id="error"><strong>Error <%= request.getParameter("error") %></strong>: <%= request.getParameter("message") %></p>
        <% } %>
    <h2>Welcome to SenVote, <%= user.name %>! &emsp;&emsp;&emsp; <a href="SignOutServlet" style="display: inline-block;">Sign Out of SenVote</a></h2>

    <a href="divisions.jsp">Division List</a>
    <% if(user.accountActive) %> <a href="active-divisions.jsp">Open Divisions</a>

    <% if(user.accessLevel == 1) { %>
        <br/><h3>SenVote Administration</h3>
        <a href="add-user.jsp">Add a User</a>
        <a href="edit.jsp?edit=user">Edit an Existing User</a>
        <a href="delete-user.jsp">Delete an Existing User</a>
        <a href="add-division.jsp">Add a Division</a>
        <a href="edit.jsp?edit=division">Edit an Existing Division</a>
        <a href="delete-division.jsp">Delete an Existing Division</a>
    <% } %>
</div>

<hr/>

</body>
</html>