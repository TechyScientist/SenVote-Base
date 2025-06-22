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
    <% if(session.getAttribute("user") == null) response.sendRedirect("index.jsp?error=401 (Unauthorized)&message=You must be signed in to access this page. 3");
        User user = (User)session.getAttribute("user");
        if(user.accessLevel != 1) response.sendRedirect("dashboard.jsp?error=401 (Unauthorized)&message=You must be a SenVote administrator to access this page.");
        if(request.getParameter("error") != null && request.getParameter("message") != null) { %>
        <p id="error"><strong>Error <%= request.getParameter("error") %></strong>: <%= request.getParameter("message") %></p>
    <% } else if(request.getParameter("added") != null) { %>
        <p id="success">The user <strong><%= request.getParameter("added") %></strong> was added to SenVote successfully</p>
    <% } %>
    <h2>Add a User&emsp;&emsp;&emsp; <a href="dashboard.jsp" style="display: inline-block;">Return to Dashboard</a></h2>
    <p>You can use this page to add a user to the SenVote platform.</p>
    <p><strong>Standard</strong> users do not have any access to administrative functions, while <strong>Administrator</strong> users do.</p>
    <p><strong>Active</strong> user accounts can participate in active votes or carry out administrator functions, while <strong>Inactive</strong> user accounts can only view closed votes.</p>
    <form action="AddUserServlet" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" placeholder="Username" required/><br/><br/>
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" placeholder="Name" required/><br/><br/>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" placeholder="Password" required/><br/><br/>
        <label for="confirm-password">Confirm Password:</label>
        <input type="password" id="confirm-password" name="confirm-password" placeholder="Confirm Password" required/><br/><br/>
        <label for="access">Access Level:</label>
        <select id="access" name="accessLevel">
            <option value="0">Standard</option>
            <option value="1">Administrator</option>
        </select><br/><br/>
        <label for="active">Account Status:</label>
        <select id="active" name="active">
            <option value="1">Active - Can Vote</option>
            <option value="0">Inactive - Cannot Vote</option>
        </select><br/><br/>
        <input type="submit" name="senvote-add-user-submit" value="Add User" />
    </form>
</div>

<hr/>

</body>
</html>