<!-- Registration Confirmation Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="description" content="Confirmation Page">
    <meta name="keywords" content="HTML, JSP, CSS">
    <meta name="author" content="Jeffrey Reid">

    <link rel="stylesheet" href="Confirmation.css">
	
	<title>Registration Page</title>
	
</head>
<body>

	<!-- This imports the NavBar into the page -->
	<jsp:include page="Navbar.jsp" flush="true"></jsp:include>

	<div id="confirm">
	
        <h2> Account Created! </h2>
        <br>
        <br>
        
        <form action="index.jsp" method="Post">
            <input type="hidden" name="this" value="returntoLand">
            <input class="confirmtohome" type="submit" id="returntoLand" value="Return to Home Page">
        </form>
	
	</div>
	
	<!-- This imports the Footer into the page below everything -->
	<jsp:include page="Foot.jsp" flush="true"></jsp:include>

</body>
</html>