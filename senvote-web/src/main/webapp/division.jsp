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
        DivisionItemDaoLocal divisionItemDaoLocal = (DivisionItemDaoLocal) session.getAttribute("divisionitemdao");
        int id = Integer.parseInt(request.getParameter("id"));
        DivisionItem divisionItem = divisionItemDaoLocal.byId(id);
        SimpleDateFormat format = new SimpleDateFormat("d MMMM yyyy, h:mm a"); %>

    <%
    if(divisionItem != null) {%>
    <h2>SenVote Division <%= id %>: <%= divisionItem.title %> &emsp;&emsp;&emsp; <a href=" <%=request.getParameter("source") %>.jsp">Return to Division List</a> &emsp;&emsp;&emsp; <a href="dashboard.jsp" style="display: inline-block;">SenVote Dashboard</a></h2>
        <table>
            <tr>
                <th>Division ID</th>
                <td><%= divisionItem.id %></td>
            </tr>
            <tr>
                <th>Type of Division</th>
                <td><%= divisionItem.type %></td>
            </tr>
            <tr>
                <th>Division Title</th>
                <td><%= divisionItem.title %></td>
            </tr>
            <tr>
                <th>Division Text</th>
                <td><%= divisionItem.text.replace("\n", "<br/>") %></td>
            </tr>
            <tr>
                <th>Voting Period</th>
                <td><%= format.format(divisionItem.start) %> to <%= format.format(divisionItem.end) %></td>
            </tr>
        </table>
    <%} else {
        response.sendRedirect(request.getParameter("source") + ".jsp?error=409 (Conflict)&message=Division ID" + id + " does not exist in SenVote.");
    }%>
</div>

<hr/>

</body>
</html>