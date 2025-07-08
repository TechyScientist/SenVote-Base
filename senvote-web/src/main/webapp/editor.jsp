<%@ page import="com.johnnyconsole.senvote.persistence.User" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.johnnyconsole.senvote.servlet.util.Database" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.time.ZoneOffset" %>
<%@ page import="java.time.ZoneId" %>
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
  <% if(edit.equals("User")) { %>
  <h2>Editing: <%= edit + " " + request.getParameter("username") %> &emsp;&emsp;&emsp; <a href="dashboard.jsp" style="display: inline-block;">Return to Dashboard</a></h2>
  <%
    try(PreparedStatement stmt = Database.connect().prepareStatement("SELECT * FROM senvote_users WHERE username=?;")){
    stmt.setString(1, request.getParameter("username"));
    ResultSet set = stmt.executeQuery();
    if(set.next()) { %>
  <form action="EditUserServlet" method="post">
    <input type="hidden" id="username" name="username" value="<%= request.getParameter("username") %>"/>
    <label for="username">Username</label>
    <input type="text" name="username" id="username" value="<%= request.getParameter("username") %>" disabled required /><br/><br/>
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" value="<%= set.getString("name") %>" required/><br/><br/>
    <label for="password">Change Password:</label>
    <input type="password" id="password" name="password" placeholder="Password"/><br/><br/>
    <label for="confirm-password">Confirm Password:</label>
    <input type="password" id="confirm-password" name="confirm-password" placeholder="Confirm Password"/><br/><br/>
    <label for="access">Access Level:</label>
    <select id="access" name="accessLevel">
      <option value="0" <% if(set.getString("accessLevel").equals("0")) { %> selected <% } %>>Standard</option>
      <option value="1" <% if(set.getString("accessLevel").equals("1")) { %> selected <% } %>>Administrator</option>
    </select><br/><br/>
    <label for="active">Account Status:</label>
    <select id="active" name="active">
      <option value="1" <% if(set.getString("accountActive").equals("1")) { %> selected <% } %>>Active - Can Vote</option>
      <option value="0" <% if(set.getString("accountActive").equals("0")) { %> selected <% } %>>Inactive - Cannot Vote</option>
    </select><br/><br/>
    <input type="submit" name="senvote-edit-user-submit" value="Save Changes" />
  </form>
  <% }
      else {
      response.sendRedirect("edit.jsp?error=209 (Conflict)&message=User \"" + request.getParameter("username") + "\" does not exist in SenVote.");
    }
  } catch(SQLException e) {
    throw new RuntimeException(e);
  }
  } else if(edit.equals("Division")) { %>
  <h2>Editing: <%= edit + " " + request.getParameter("division") %> &emsp;&emsp;&emsp; <a href="dashboard.jsp" style="display: inline-block;">Return to Dashboard</a></h2>
  <%
    try(PreparedStatement stmt = Database.connect().prepareStatement("SELECT * FROM senvote_divisionitems WHERE id=?;")){
      stmt.setInt(1, Integer.parseInt(request.getParameter("division")));
      ResultSet set = stmt.executeQuery();
      if(set.next()) { %>

  <form action="EditDivisionServlet" method="post">
    <input type="hidden" id="id" name="id" value="<%= request.getParameter("division") %>"/>
    <label for="id">Division ID:</label>
    <input type="text" id="id" name="id" value="<%= request.getParameter("division") %>" disabled required/><br/><br/>
    <label for="title">Title:</label>
    <input type="text" id="title" name="title" placeholder="Tile" value="<%= set.getString("title") %>"required/><br/><br/>
    <label for="type">Type:</label>
    <select id="type" name="type">
      <option <% if(set.getString("type").equals("Consent Division")) { %> selected <% } %>> Consent Division</option>
      <option <% if(set.getString("type").equals("Yea/Nay Division")) { %> selected <% } %>>Yea/Nay Division</option>
      <option <% if(set.getString("type").equals("Recorded Division")) { %> selected <% } %>>Recorded Division</option>
    </select><br/><br/>
    <label for="text" style="vertical-align: top;">Division Text:</label>
    <textarea id="text" name="text" placeholder="Division Text" required><%= set.getString("text") %></textarea><br/><br/>
    <label for="start">Available Starting:</label>
    <input type="datetime-local" id="start" name="start" value="<%= set.getTimestamp("start").toInstant().atZone(ZoneId.of("America/Toronto")).toLocalDateTime() %>" required/><br/><br/>
    <label for="end">Available Until:</label>
    <input type="datetime-local" id="end" name="end" value="<%= set.getTimestamp("end").toInstant().atZone(ZoneId.of("America/Toronto")).toLocalDateTime() %>" required/><br/><br/>
    <input type="submit" name="senvote-edit-division-submit" value="Save Changes" />
  </form>
  <% } else {
    response.sendRedirect("edit.jsp?error=209 (Conflict)&message=Division ID \"" + request.getParameter("division") + "\" does not exist in SenVote.");
  }
  } catch(SQLException e) {
      throw new RuntimeException(e);
  }
  } else {
    response.sendRedirect("dashboard.jsp?error=209 (Conflict)&message=Invalid URL Parameter value.");
  }
  %>
</div>

<hr/>

</body>
</html>