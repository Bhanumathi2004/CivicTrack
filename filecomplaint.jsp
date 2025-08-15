<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) response.sendRedirect("login.jsp");
%>
<h2>File New Complaint</h2>
<form action="ComplaintServlet" method="post">
<input type="hidden" name="userId" value="<%= user.getId() %>">
    Title: <input type="text" name="title"><br>
    Description:<br>
<textarea name="description"></textarea><br>
<input type="submit" value="Submit Complaint">
</form>
