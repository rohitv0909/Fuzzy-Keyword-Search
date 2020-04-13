<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
<link rel="stylesheet"
	href="/fks/bootstrapfiles/bootstrap.min.css" type="text/css">
<script src="/fks/bootstrapfiles/bootstrap.min.js"></script>
<script src="/fks/bootstrapfiles/jquery-3.3.1.min.js"></script>
<script src="/fks/js/validation.js"></script>
<script>
	function main() {
		var ui = document.getElementById("txtuserid").value;
		var upass = document.getElementById("txtuserpass").value;
		var b = true
		if (checkEmpty(ui) == false) {
			/* alert("USerID needed") */
			document.getElementById("msgid").innerHTML = "Please enter user id"
			document.getElementById("txtuserid").focus()
			b = false
		}
		if (checkEmpty(ui) == true) {
			/* alert("USerID needed") */
			document.getElementById("msgid").innerHTML = ""
		}
		if (checkEmpty(upass) == false) {
			//alert("User Password needed")
			document.getElementById("msgpass").innerHTML = "Please enter user password"
			document.getElementById("txtuserpass").focus()
			b = false
		} else if (checkLength(upass) == false) {
			//alert("Please enter password length of 9 or more characters")
			document.getElementById("msgpass").innerHTML = "Password length should be > 8 characters"
			document.getElementById("txtuserpass").focus()
			b = false
		}
		return b
		//alert(ui)
	}
</script>
</head>
<body style="background-image: url('/fks/images/cldlgn.jpg');">
	<%
		String ms = (String) request.getAttribute("msg");
	%>
	<div style="width: 55%; height: 200px; float: left; font-size: 40px; margin-left: 5%; color: cyan;">Cloud Portal</div>
	<div style="width: 40%; height: 200px; float: left">

		<!-- <div style="width: 80px; float: left; margin-top: 5px">
			<a href="/fks/jsp/home.jsp">Home</a>
		</div>

		<div
			style="width: 100px; float: left; margin-top: 5px; margin-left: 10px">
			<a href="/fks/html/contactus.html">Contact Us</a>
		</div> -->
	</div>
	<div
		style="width: 60%; margin-left: 20%; margin-right: 20%; height: 100%; float: left;">
		<form action="/fks/Login" method="post"
			onsubmit="return main()">
			<table align="center" style="margin-top: 50px;">
				<tr>
					<th style="width: 100px">User ID</th>
					<th><input type="text" id="txtuserid" name="txtuserid"
						placeholder="Enter UserID" autofocus="autofocus"></th>
				</tr>
				<tr style="height: 50px">
					<th>Password</th>
					<th><input type="password" id="txtuserpass" name="txtuserpass"
						placeholder="Enter password"></th>
				</tr>
				<tr>
					<td align="center" colspan="2" style="height: 50px"><button type="submit">Login</button></td>
				</tr>
				<tr>
					<td align="center" colspan="2" style="height: 50px;"><a href="/fks/reg.jsp" style="color: red;">New here, sign up with us!!</a></td>
				</tr>
			</table>
			<%
				if (ms != null) {
			%>
			<h2 style="color: red;"><%=ms%></h2>
			<%
				}
			%>

			<h5 id="msgid" style="color: red"></h5>
			<h5 id="msgpass" style="color: red"></h5>
		</form>
	</div>
</body>
</html>