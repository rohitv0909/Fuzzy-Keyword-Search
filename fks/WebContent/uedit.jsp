<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*,fks.dbtasks.*,fks.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Profile</title>
<link rel="stylesheet"
	href="/fks/bootstrapfiles/bootstrap.min.css" type="text/css">
<script src="/fks/bootstrapfiles/bootstrap.min.js"></script>
<script src="/fks/bootstrapfiles/jquery-3.3.1.min.js"></script>
<script src="/fks/js/validation.js"></script>
</head>
<body>
<div
		style="width: 100%; height: 80px; background-color: #6882d1; float: left">
		<h1 style="text-align: center;">Edit Profile</h1>
	</div>
	<div style="width: 20%; height: 700px; float: left">
		<%@include file="/html/user_menu.html"%>
	</div>
	<div style="width: 80%; height: 700px; float: left">
	<form action="/fks/EditProfile" method="post">
	<table style="margin-top: 100px;margin-left: 100px;font-size: 20px">
	<%
		HttpSession hs=request.getSession(false);
		String uid=(String)hs.getAttribute("userid");
		String strsql="select * from logininfo where userid=?";
		ResultSet rs=CrudOperation.fetchData(strsql,uid);
		if(rs.next())
		{
			final String key="ssshhhhhhhhhhh!!!!";
			hs.setAttribute("userpass", AES.decrypt(rs.getString(2), key));
			hs.setAttribute("role",rs.getString(5));
		%>
				<tr>
					<th>User Name</th>
					<th><input type="text" id="txtusername" name="txtusername" required value="<%=AES.decrypt(rs.getString(3), key) %>"></th>
				</tr>
				<tr>
					<th>Email ID</th>
					<th><input type="email" id="txtmail" name="txtmail" required value="<%=AES.decrypt(rs.getString(4), key) %>"></th>
				</tr>
				<tr>
					<th>Enter current password to authenticate:</th>
					<th><input type="password" id="pass" name="pass" placeholder="enter current password" 
					required></th>
				</tr>
				<tr>
					<td align="center"><button type="submit">Submit</button></td>
				</tr>
				<%
		}
		rs.close();
				%>
	</table>
	</form>
	<% String message = (String)request.getAttribute("msg");%>
	<script type="text/javascript">
    var msg = "<%=message%>";
    alert(msg);
	</script>
	</div>
</body>
</html>