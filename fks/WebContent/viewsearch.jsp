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
		<tr><th>File Name</th><th>Download</th>
		</tr>
		<%
		String ms = (String) request.getAttribute("resultMessage");
		HttpSession hs=request.getSession(false);
		String uid=(String)hs.getAttribute("userid");
		String sid=request.getParameter("sid");
		String strsql="select * from document";
		ResultSet rs=CrudOperation.fetchData(strsql);		
		while(rs.next())
		{
			String enfname=rs.getString("fname");
			String fname=AES.decrypt(enfname,rs.getString("key"));
			String fpath="E:\\upload\\"+enfname;
			String fnm=fname.substring(0, fname.indexOf("."));
			if(fnm.equalsIgnoreCase(sid))
			{
			%>
			<tr>
			<td><%=fname %></td>
			<td><a href="DownloadServlet?valName=<%=enfname%>&key=<%=rs.getString("key")%>">Download</a></td>
			</tr>
			<%}
			else if(edst.calculate(sid, fnm)<=3)
			{
				%>
				<tr>
				<td><%=fname %></td>
				<% String fnme=enfname; %>
				<td><a href="DownloadServlet?valName=<%=enfname%>&key=<%=rs.getString("key")%>">Download</a></td>
				</tr>
				<%-- <%
				if (ms != null) {
				%>
				<tr>
				<td>Enter OTP</td>
				<td><input type="text" id="txtuserotp" name="txtuserotp"
						placeholder="enter otp" required></td>
				</tr>
				<tr>
				<td colspan="2"><button type="submit">Submit</button></td>
				</tr>
				<%
					}
				%> --%>
					<%
			}
		}
		rs.close();%>
		</table>
</div>
</body>
</html>