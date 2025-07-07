<%@ page import="com.johnnyconsole.senvote.persistence.User" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.johnnyconsole.senvote.servlet.util.Database" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
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
    User user = (User)session.getAttribute("user");
    if(user.accessLevel != 1) response.sendRedirect("dashboard.jsp?error=401 (Unauthorized)&message=You must be a SenVote administrator to access this page.");
    if(request.getParameter("edit") == null) response.sendRedirect("dashboard.jsp?error=409 (Conflict)&message=Missing URL parameter.");
    String edit = request.getParameter("edit");
    edit = new StringBuilder(edit).replace(0, 1, String.valueOf((char)(edit.charAt(0) ^ 32))).toString();
    if(request.getParameter("error") != null && request.getParameter("message") != null) { %>
  <p id="error"><strong>Error <%= request.getParameter("error") %></strong>: <%= request.getParameter("message") %></p>
  <% } else if(request.getParameter("saved") != null) { %>
  <p id="success">The <%= request.getParameter("edit") %> <strong><%= request.getParameter("saved") %></strong> was updated successfully</p>
  <% } %>
    <h2>Edit a <%= edit %> &emsp;&emsp;&emsp; <a href="dashboard.jsp" style="display: inline-block;">Return to Dashboard</a></h2>
  <% if(edit.equals("User")) { %>
    <p>You can use this page to edit an existing user.</p>
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

  <form action="editor.jsp" method="get">
    <input type="hidden" name="edit" value="user"/>
    <label for="user">User to Edit:</label>
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
    <input type="submit" name="senvote-edit-submit" value="Edit User" />
  </form>
  <% } else { %>
  <p id="error"><strong>Error 204 (No Content)</strong>: No Users Found</p>
  <% }
  } else if(edit.equals("Division")) { %>
  <p>You can use this page to edit an existing user.</p>
  <%
    int divisions = 0;
    try (Connection conn = Database.connect()) {
      PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(id) AS count FROM senvote_divisionitems;");
      ResultSet rs = stmt.executeQuery();
      divisions = rs.next() ? rs.getInt("count") : 0;
    } catch (SQLException e) {
      throw new RuntimeException(e);
    }

    if(divisions > 0) {
  %>

  <form action="editor.jsp" method="get">
    <input type="hidden" name="edit" value="division"/>
    <label for="division">Division to Edit:</label>
    <select name="division" id="division">
      <%
        try (Connection conn = Database.connect()) {
          PreparedStatement stmt = conn.prepareStatement("SELECT id, title FROM senvote_divisionitems;");
          ResultSet rs = stmt.executeQuery();
          while(rs.next()) {
            String id = rs.getString("id"),
                    title = rs.getString("title");
      %>
      <option value="<%=id%>"><%="Division" + id + " (" + title + ")"%></option>
      <%        }
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
      %>
    </select><br/><br/>
    <input type="submit" name="senvote-edit-submit" value="Edit Division" />
  </form>
  <% } else { %>
  <p id="error"><strong>Error 204 (No Content)</strong>: No Divisions Found</p>
  <% }
  } else {
    response.sendRedirect("dashboard.jsp?error=209 (Conflict)&message=Invalid URL Parameter value.");
  }
  %>
</div>

<hr/>

</body>
</html>