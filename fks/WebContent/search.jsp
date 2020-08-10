<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*,fks.dbtasks.CrudOperation,java.io.*,fks.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Home</title>
<link rel="stylesheet"
	href="/fks/bootstrapfiles/bootstrap.min.css" type="text/css">
<script src="/fks/bootstrapfiles/bootstrap.min.js"></script>
<script src="/fks/bootstrapfiles/jquery-3.3.1.min.js"></script>
<script src="/fks/js/validation.js"></script>
</head>
<body>
<div
		style="width: 100%; height: 80px; background-color: #6882d1; float: left">
		<h1 style="text-align: center;">Search Files</h1>
	</div>
	<div style="width: 20%; height: 700px; float: left">
		<%@include file="/html/user_menu.html"%>
	</div>
	<div style="width: 80%; height: 700px; float: left">
	<%-- <%
	HttpSession hs=request.getSession(false);
	String uid=(String)hs.getAttribute("userid");
	String strsql="select * from auth where userid=?";
	ResultSet rs=CrudOperation.fetchData(strsql,uid);		
	if(rs.getString("request").equalsIgnoreCase("no"))
	{
	%>
		<form action="/fks/Authenticate" method="post">
		<table border="0" width="300" align="center" bgcolor="#e9f">
        <tr><td colspan=2 style="font-size:12pt;" align="center">
        <button type="submit">Get Authenticated</button></td></tr>
        </table>
        </form>
	<%
	}
	else
	{
	%> --%>
	<form action="viewsearch.jsp">
      <table border="0" width="300" align="center" bgcolor="#e9f">
        <tr><td colspan=2 style="font-size:12pt;" align="center">
        <tr><td ><b>Search Text</b></td>
          <td>: <input type="text" name="sid" id="sid">
        </td></tr>        
        <tr><td colspan=2 align="center">
        <input type="submit" name="submit" id="button_1" value="Search" onclick = "clearcontent('clear')"></td></tr>
      </table>
    </form>
	<%-- <%
	}
	rs.close();
	%> --%>
	</div>
</body>
</html>