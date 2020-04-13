<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*,fks.dbtasks.*,java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Check ID</title>
<link rel="stylesheet"
	href="/fks/bootstrapfiles/bootstrap.min.css" type="text/css">
<script src="/fks/bootstrapfiles/bootstrap.min.js"></script>
<script src="/fks/bootstrapfiles/jquery-3.3.1.min.js"></script>
<script src="/fks/js/validation.js"></script>
</head>
<body>

<%
response.setContentType("text/html");
PrintWriter o=response.getWriter();
String id=request.getParameter("recid");
System.out.println(id);
	String str1="select * from logininfo where userid=?";
	ResultSet rs=CrudOperation.fetchData(str1, id);
			if(rs.next())
			{
				out.println("<p style='color: red;'>ID already taken</p>");
			}
			else
			{
				out.println("<p style='color: green;'>ID available</p>");
			}
			rs.close();%>
</body>
</html>