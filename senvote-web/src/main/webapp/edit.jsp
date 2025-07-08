<%@ page import="com.johnnyconsole.senvote.persistence.User" %>
<%@ page import="com.johnnyconsole.senvote.persistence.interfaces.DivisionItemDaoLocal" %>
<%@ page import="com.johnnyconsole.senvote.persistence.DivisionItem" %>
<%@ page import="java.util.List" %>
<%@ page import="com.johnnyconsole.senvote.persistence.interfaces.UserDaoLocal" %>
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
    UserDaoLocal userDao = (UserDaoLocal) session.getAttribute("userdao");
    if(userDao.userCount() > 0) {
  %>

  <form action="editor.jsp" method="get">
    <input type="hidden" name="edit" value="user"/>
    <label for="username">User to Edit:</label>
    <select name="username" id="username">
      <%
        List<User> userList = userDao.getUsersExcept(user.username);
        for(User x: userList) {
            String u = x.username,
                    n = x.name;
      %>
      <option value="<%=u%>"><%=n + " (" + u + ")"%></option>
      <% } %>
    </select><br/><br/>
    <input type="submit" name="senvote-edit-submit" value="Edit User" />
  </form>
  <% } else { %>
  <p id="error"><strong>Error 204 (No Content)</strong>: No Users Found</p>
  <% }
  } else if(edit.equals("Division")) { %>
  <p>You can use this page to edit an existing division item.</p>
  <% DivisionItemDaoLocal divisionDao = (DivisionItemDaoLocal) session.getAttribute("divisionitemdao");
    if(divisionDao.count() > 0) {
  %>

  <form action="editor.jsp" method="get">
    <input type="hidden" name="edit" value="division"/>
    <label for="division">Division to Edit:</label>
    <select name="division" id="division">
      <%
        List<DivisionItem> items = divisionDao.all();
         for(DivisionItem item : items) {
            String id = String.valueOf(item.id),
                    title = item.title;
      %>
      <option value="<%=id%>"><%="Division " + id + " (" + title + ")"%></option>
      <%        } %>
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