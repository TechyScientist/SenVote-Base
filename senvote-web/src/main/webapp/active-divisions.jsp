<%@ page import="com.johnnyconsole.senvote.persistence.interfaces.DivisionItemDaoLocal" %>
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
        DivisionItemDaoLocal divisionItemDaoLocal = (DivisionItemDaoLocal) session.getAttribute("divisionitemdao"); %>

    <h2>Active Divisions List &emsp;&emsp;&emsp; <a href="dashboard.jsp" style="display: inline-block;">SenVote Dashboard</a></h2>

    <% if(divisionItemDaoLocal.activeCount() == 0) { %>
        <p id="error"><strong>Error 204 (No Content):</strong> No Divisions are Active</p>
    <% }
       else {
        //TODO: Add Active Divisions
     }
    %>
</div>

<hr/>

</body>
</html>