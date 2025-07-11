<%@ page import="com.johnnyconsole.senvote.persistence.User" %>
<%@ page import="com.johnnyconsole.senvote.persistence.interfaces.DivisionItemDaoLocal" %>
<%@ page import="com.johnnyconsole.senvote.persistence.DivisionItem" %>
<%@ page import="java.util.List" %>
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
        DivisionItemDaoLocal divisionDao = (DivisionItemDaoLocal) session.getAttribute("divisionitemdao");
        if(user.accessLevel != 1) response.sendRedirect("dashboard.jsp?error=401 (Unauthorized)&message=You must be a SenVote administrator to access this page.");
        if(request.getParameter("error") != null && request.getParameter("message") != null) { %>
        <p id="error"><strong>Error <%= request.getParameter("error") %></strong>: <%= request.getParameter("message") %></p>
    <% } else if(request.getParameter("deleted") != null) { %>
        <p id="success">The division item with ID  <strong>Division <%= request.getParameter("deleted") %></strong> was deleted from SenVote successfully</p>
    <% } %>
    <h2>Delete an Existing Division&emsp;&emsp;&emsp; <a href="dashboard.jsp" style="display: inline-block;">Return to Dashboard</a></h2>
    <p>You can use this page to delete a division item from the SenVote platform.</p>
    <p id="warning"><strong>Warning</strong>: Deleting a division item is permanent and cannot be undone. All votes recorded for the division item being deleted will be removed from SenVote.</p>

    <% if(divisionDao.count() > 0) { %>
    <form action="DeleteDivisionServlet" method="post">
        <label for="division">Division Item to Delete:</label>
        <select name="division" id="division">
            <% List<DivisionItem> divisions = divisionDao.all();

                    for(DivisionItem item : divisions) {
                        String id = String.valueOf(item.id),
                                title = item.title;
            %>
            <option value="<%= id %>">Division <%= id + " (" + title + ")"%></option>
            <%        } %>
        </select><br/><br/>
        <input type="hidden" name="sender" value="<%= user.username %>"/>
        <input type="submit" name="senvote-delete-division-submit" value="Delete Division" />
    </form>
    <% } else { %>
       <p id="error"><strong>Error 204 (No Content)</strong>: No Divisions Found</p>
<% } %>
</div>

<hr/>

</body>
</html>