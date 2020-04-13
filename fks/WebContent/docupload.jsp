<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Upload The Documents</title>
<link rel="stylesheet"
	href="/fks/bootstrapfiles/bootstrap.min.css" type="text/css">
<script src="/fks/bootstrapfiles/bootstrap.min.js"></script>
<script src="/fks/bootstrapfiles/jquery-3.3.1.min.js"></script>
<script src="/fks/js/validation.js"></script>
<script>
	function main() {
		
		var userid = document.getElementById("txtuserid").value;
		var filename = document.getElementById("txtfilename").value;
		var docid = document.getElementById("txtdocid").value;
		var b = true

		if (checkEmpty(filename) == false) {
			//alert("userpass needed")
			    document.getElementById("msgname").innerHTML = "File Name required"
				document.getElementById("txtfilename").focus()
			b = false
		}
		else if (checkEmpty(filename) == true) {
			document.getElementById("msgname").innerHTML = ""
		}
		
		return b
		//alert(ui)
	}
</script>
</head>
<body>
<%
HttpSession hs = request.getSession(false);
String uid = (String) hs.getAttribute("userid");
%>
<div
		style="width: 100%; height: 80px; background-color: #6882d1; float: left">
		<h1 style="text-align: center;">Upload Documents</h1>
	</div>
	<div style="width: 20%; height: 700px; float: left">
		<%@include file="/html/dataowner_menu.html"%>
	</div>
	<div style="width: 80%; height: 700px; float: left; background-image: url('/fks/images/docpat.jpg');">
		<form method="post" action="FileUploadHandle" onsubmit="return main()" enctype="multipart/form-data">

			<table border="0" class="register"
				style="margin-top: 50px; margin-left: 80px; width: 520px;">
				<tr>
					<th>Select the document</th>
					<th><input type="file" name="uploadFile" id="uploadFile" required/></th>
				</tr>
				
				<tr>
					<th>Data Owner Id</th>
					<th><input type="text" id="txtuserid" name="txtuserid"
						value=<%=uid%> readonly="readonly"></th>
				</tr>
				<tr>
					<th colspan="2" id="msgid1" style="color: red;font-size: small;"></th>


				</tr>
				<tr>
					<th>File Name</th>
					<th><input type="text" id="txtfilename" name="txtfilename"
						placeholder="enter file name" required></th>
				</tr>
				<tr>
					<th colspan="2" id="msgname" style="color: red;font-size: small;"></th>
				</tr>
							    
				<tr>
					<td align="center"><button type="submit">Submit</button>
						<button type="reset">Reset</button></td>
				</tr>
			</table>
		</form>
		<%
           String file_name=(String)request.getParameter("filename");
           if(file_name!=null){
        	   out.println(file_name+" File uploaded successfuly");
           }
           %>
	</div>
</body>
</html>