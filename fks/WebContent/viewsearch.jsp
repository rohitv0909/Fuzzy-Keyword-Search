<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*,fks.dbtasks.*,java.io.*,fks.servlet.*" %>
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
<style>
table {
  border-collapse: collapse;
}

table, th, td {
  border: 1px solid black;
}
textarea {
    display: block;
    margin-left: auto;
    margin-right: auto;
}
</style>
</head>
<body>
<div
		style="width: 100%; height: 80px; background-color: #6882d1; float: left">
		<h1 style="text-align: center;">View Search Result(s)</h1>
	</div>
	<div style="width: 20%; height: 700px; float: left">
		<%@include file="/html/user_menu.html"%>
	</div>
	<div style="overflow-x:auto; width: 80%; height: 700px; float: left; background-image: url('/fks/images/docpat.jpg');">
	<table style="margin-top: 100px;margin-left: 100px;font-size: 20px">
		<tr><th>File Name</th>
		</tr>
		<%
		HttpSession hs=request.getSession(false);
		String uid=(String)hs.getAttribute("userid");
		String sid=request.getParameter("sid");
		String strsql="select * from document";
		ResultSet rs=CrudOperation.fetchData(strsql);		
		while(rs.next())
		{
			String fname=AES.decrypt(rs.getString("fname"),rs.getString("key"));
			String fnm=fname.substring(0, fname.indexOf("."));
			if(fnm.equalsIgnoreCase(sid))
			{
			%>
			<tr>
			<td><%=fnm %></td>
			</tr>
			<%}
			else if(edst.calculate(sid, fnm)<=3)
			{
				%>
				<tr>
				<td><%=fname %></td>
				</tr>
				<%
			}
		}
		rs.close();%>
		</table>	
</div>
</body>
</html>