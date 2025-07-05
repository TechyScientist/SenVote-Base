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
        <p id="success">The Division ID <strong><%= request.getParameter("id") %></strong> (Title: <strong><%= request.getParameter("title") %></strong>) was added to SenVote successfully</p>
    <% } %>
    <h2>Add a Division&emsp;&emsp;&emsp; <a href="dashboard.jsp" style="display: inline-block;">Return to Dashboard</a></h2>
    <p>You can use this page to add a division item to the SenVote platform.</p>
   <p><strong>Consent Divisions</strong> will not be votable: the result of a consent division must be added to the division item by a SenVote administrator after the division takes place.</p>
    <p><strong>Yea/Nay Divisions</strong> will not report who voted for or against the division item, but will count the number of for, against, paired, or abstention votes cast.</p>
    <p><strong>Recorded Divisions</strong> will report the names of users who voted, how they voted, and the total count of for, against, paired or abstention votes for the division item.</p>
    <form action="AddDivisionServlet" method="post">
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" placeholder="Tile" required/><br/><br/>
        <label for="type">Type:</label>
        <select id="type" name="type">
            <option>Consent Division</option>
            <option>Yea/Nay Division</option>
            <option>Recorded Division</option>
        </select><br/><br/>
        <label for="text">Division Text:</label>
        <textarea id="text" name="text" placeholder="Division Text" required></textarea><br/><br/>
        <label for="start">Available Starting:</label>
        <input type="datetime-local" id="start" name="start" required/><br/><br/>
        <label for="end">Available Until:</label>
        <input type="datetime-local" id="end" name="end" required/><br/><br/>
        <input type="submit" name="senvote-add-division-submit" value="Add Division" />
    </form>
</div>

<hr/>

</body>
</html>