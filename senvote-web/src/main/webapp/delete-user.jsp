<%@ page import="com.johnnyconsole.senvote.persistence.User" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.johnnyconsole.senvote.servlet.util.Database" %>
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
    <% } else if(request.getParameter("deleted") != null) { %>
        <p id="success">The user <strong><%= request.getParameter("deleted") %></strong> was deleted from SenVote successfully</p>
    <% } %>
    <h2>Delete an Existing User&emsp;&emsp;&emsp; <a href="dashboard.jsp" style="display: inline-block;">Return to Dashboard</a></h2>
    <p>You can use this page to delete a user from the SenVote platform.</p>
    <p id="warning"><strong>Warning</strong>: Deleting a SenVote account is permanent and cannot be undone. All votes made by the account being deleted will be removed from SenVote.</p>

    <%
        int users = 0;
        try (Connection conn = Database.connect()) {
            PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(username) AS count FROM senvote_users WHERE username<>?;");
            stmt.setString(1, user.username);
            ResultSet rs = stmt.executeQuery();
            users = rs.next() ? rs.getInt("count") : 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if(users > 0) {
    %>

    <form action="DeleteUserServlet" method="post">
        <label for="user">User to Delete:</label>
        <select name="user" id="user">
            <%
                try (Connection conn = Database.connect()) {
                    PreparedStatement stmt = conn.prepareStatement("SELECT username, name FROM senvote_users WHERE username<>?;");
                    stmt.setString(1, user.username);
                    ResultSet rs = stmt.executeQuery();
                    while(rs.next()) {
                        String u = rs.getString("username"),
                                n = rs.getString("name");
            %>
            <option value="<%=u%>"><%=n + " (" + u + ")"%></option>
            <%        }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            %>
        </select><br/><br/>
        <input type="hidden" name="sender" value="<%= user.username %>"/>
        <input type="submit" name="senvote-delete-user-submit" value="Delete User" />
    </form>
    <% } else { %>
       <p id="error"><strong>Error 204 (No Content)</strong>: No Users Found</p>
<% } %>
</div>

<hr/>

</body>
</html>