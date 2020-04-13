<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*,fks.dbtasks.*,fks.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Uploaded Documents</title>
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
		<h1 style="text-align: center;">View Uploaded Documents</h1>
	</div>
	<div style="width: 20%; height: 700px; float: left">
		<%@include file="/html/dataowner_menu.html"%>
	</div>
	<div style="overflow-x:auto; width: 80%; height: 700px; float: left; background-image: url('/fks/images/docpat.jpg');">
	<table style="margin-top: 100px;margin-left: 100px;font-size: 20px">
		<tr><th>File Name</th>
		<th>Encrypted File Name</th>
		<th>File Path</th>
		<th>Encrypted File Path</th>
		</tr>
		<%
		HttpSession hs=request.getSession(false);
		String uid=(String)hs.getAttribute("userid");
		String key=(String)hs.getAttribute("userkey");
		String strsql="select * from document where userid=?";
		ResultSet rs=CrudOperation.fetchData(strsql,uid);		
		while(rs.next())
		{
		%>
		<tr>
		<td><%=AES.decrypt(rs.getString("fname"), key) %></td>
		<td><%=rs.getString("fname") %></td>
		<td><%=AES.decrypt(rs.getString("fpath"), key) %></td>
		<td><%=rs.getString("fpath") %></td>
		</tr>
		<%
		}
		rs.close();%>
		</table>	
		<textarea align="center" id="myTextArea" rows="6" cols="40"></textarea>
	</div>
</body>
</html>