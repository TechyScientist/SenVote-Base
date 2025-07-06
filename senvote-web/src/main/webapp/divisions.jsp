<%@ page import="com.johnnyconsole.senvote.persistence.interfaces.DivisionItemDaoLocal" %>
<%@ page import="com.johnnyconsole.senvote.persistence.interfaces.DivisionItemDaoLocal" %>
<%@ page import="com.johnnyconsole.senvote.persistence.DivisionItem" %>
<%@ page import="java.text.SimpleDateFormat" %>
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

    <h2>Division List &emsp;&emsp;&emsp; <a href="dashboard.jsp" style="display: inline-block;">SenVote Dashboard</a></h2>

    <% if(divisionItemDaoLocal.count() == 0) { %>
        <p id="error"><strong>Error 204 (No Content):</strong> No Divisions Recorded</p>
    <% }
       else { %>
            <table>
                <tr>
                    <th>Division ID</th>
                    <th>Type of Division</th>
                    <th>Division Title</th>
                    <th>Voting Period</th>
                    <th>View</th>
                </tr>
          <% for(DivisionItem item : divisionItemDaoLocal.all()) {
                SimpleDateFormat format = new SimpleDateFormat("d MMMM yyyy, h:mm a");%>
                <tr>
                    <td><%= item.id %></td>
                    <td><%= item.type%></td>
                    <td><%= item.title%></td>
                    <td><%= format.format(item.start) %> to <%= format.format(item.end) %></td>
                    <td><a href="division.jsp?source=divisions&id=<%= item.id %>">View Division</a></td>
                </tr>
           <% } %>
            </table>
     <% } %>
</div>

<hr/>

</body>
</html>