<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String auth = (String) request.getSession().getAttribute("auth");
    if(auth == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Green Super Home</title>
</head>
<body>
    <h1><%=auth%></h1>
    <form action="logout" method="post">
        <input type="submit">
    </form>
</body>
</html>