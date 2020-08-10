<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration</title>
<link rel="stylesheet"
	href="/fks/bootstrapfiles/bootstrap.min.css" type="text/css">
<script src="/fks/bootstrapfiles/bootstrap.min.js"></script>
<script src="/fks/bootstrapfiles/jquery-3.3.1.min.js"></script>
<script src="/fks/js/validation.js"></script>
<script>

$(document).ready(function()
  		{
      $("#txtuserid").blur(
      		function(){
      			var rid=this.value;
      			//alert(ui)
      			 $.get("/fks/idcheck.jsp",
      			        {
      			          recid:rid
      			          
      			        },
      			        function(data,status){
      			        	//if(data=="")
      			          //  alert("Data: " + data + "\nStatus: " + status);
      			             $("#div1").html(data);
      			             $("#div1").show();
      			             //$("#div1").hide(5000);
      			             
      			        });
      });
  });
  
	function main() {
		var ui = document.getElementById("txtuserid").value;
		var upass = document.getElementById("pass").value;
		var urole = document.getElementById("txtrole").value;
		/*var address = document.getElementById("txtaddress").value;
		var b = true */

		if (checkEmpty(ui) == false) {
			document.getElementById("msgid").innerHTML = "Patient ID required"
			document.getElementById("txtuserid").focus()
			b = false
		}
		else if (checkEmpty(ui)==true) 
		{
			document.getElementById("msgid").innerHTML = ""
		}

		if (checkEmpty(upass) == false) {
			//alert("userpass needed")
			    document.getElementById("msgpass").innerHTML = "Password required"
				document.getElementById("pass").focus()
			b = false
		}
		else if (checkEmpty(upass) == true) {
			document.getElementById("msgpass").innerHTML = ""
		}

		if (checkEmpty(urole) == false) {
			//alert("userpass needed")
			    document.getElementById("msgrole").innerHTML = "entering role required"
				document.getElementById("txtrole").focus()
			b = false
		}
		else if (checkEmpty(urole) == true) {
			document.getElementById("msgrole").innerHTML = ""
		}
		/*if (checkEmpty(address) == false) {
			//alert("userpass needed")
			    document.getElementById("msgaddress").innerHTML = "address is required"
				document.getElementById("txtaddress").focus()
			b = false
		}
		else if (checkEmpty(uphone) == true) {
			document.getElementById("msgaddress").innerHTML = ""
		}
		return b */
		//alert(ui)
	}
</script>
<style>
th{
color:#929c5c;
}
td{
color:#69c2bd;
}
</style>
</head>
<body style="background-image: url('/fks/images/cldcmp.jpg');">
<h1 style="text-align: center;color:#e35c27;">REGISTRATION</h1>
	<div style="width: 60%; height: 450px; background-color: transparent; margin-left: 20%; margin-right: 20%; border-radius: 10px;">
		<form action="/fks/Reg" method="post" onsubmit="return main()">

			<table
				style="margin-top: 50px; margin-left: 80px; height: 420px;">
				
				<tr>
					<th>Role</th>
					<td><input type="radio" name="role" value="dataowner">
					    Data Owner</td>
                    <td><input type="radio" name="role" value="user" checked>User</td>
				</tr>
				<tr>
					<th colspan="2" id="msgrole" style="color: red;font-size: small;"></th>
				</tr>
				
				<tr>
					<th style="width:200px">User ID</th>
					<th style="width:200px"><input type="text" id="txtuserid" name="txtuserid"
						placeholder="enter user id" required></th><th id="div1"></th>
				</tr>
				<tr>
					<th colspan="2" id="msgid" style="color: red;font-size: small;"></th>
				</tr>

				<tr>
					<th>User Password</th>
					<th><input type="password" id="pass" name="pass"
						placeholder="enter password" required></th>
				</tr>
				<tr>
					<th colspan="2" id="msgpass" style="color: red;font-size: small;"></th>


				</tr>
				<tr>
					<th>User Name</th>
					<th><input type="text" id="txtusername" name="txtusername"
						placeholder="enter your name" required></th>
				</tr>
				<tr>
					<th colspan="2" id="msgname" style="color: red;font-size: small;"></th>
				</tr>
				<tr>
					<th>Email ID</th>
					<th><input type="email" id="txtmail" name="txtmail"
						placeholder="enter the email id" required></th>
				</tr>
				<tr>
					<th colspan="2" id="msgmail" style="color: red;font-size: small;"></th>
				</tr>
				

				
				<!-- <tr>
					<th>Address</th>
					<th><textarea id="txtaddress" name="txtaddress" placeholder="enter address"></textarea></th>
						
				</tr>
				<tr>
					<th colspan="2" id="msgaddress" style="color: red;font-size: small;"></th>


				</tr> -->
				
				<tr>
					<td align="center"><button type="submit">Submit</button></td>
						<td align="center"><button type="reset">Reset</button></td>
				</tr>
				<tr>
					<td align="center" colspan="2" style="height: 50px;"><a href="/fks/login.jsp" style="color: magenta;">Go to Login Page.</a></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>