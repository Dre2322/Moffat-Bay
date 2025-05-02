<!-- Forgot Password Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->

<!-- Purpose:
This page allows users to request a password reset by entering their email address. Upon submission,
the form triggers a request to the `ForgotServlet`, which handles sending the password reset instructions.
The page also includes a link back to the login page for users who remember their credentials.
The layout is designed to be user-friendly with clear instructions for the password reset process. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="author" content="Jordany Gonzalez">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Forgot Password - Moffat Bay Lodge</title>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500&family=Open+Sans&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Open Sans', sans-serif;
      color: #2c3e50;
      background-color: #f2f2f2;
    }

    .container {
      width: 400px;
      margin: 10% auto 11%;
      background-color: white;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    h2 {
      text-align: center;
      margin-bottom: 25px;
    }

    label {
      display: block;
      margin-bottom: 8px;
    }

    input[type="email"] {
      width: 100%;
      padding: 10px;
      font-size: 16px;
      margin-bottom: 20px;
    }

    input[type="submit"] {
      width: 100%;
      background-color: #54d3f0;
      border: none;
      color: black;
      font-size: 16px;
      padding: 10px;
      border-radius: 8px;
      cursor: pointer;
    }

    .back {
      text-align: center;
      margin-top: 20px;
    }

    .back a {
      color: #007BFF;
      text-decoration: none;
    }

    .back a:hover {
      text-decoration: underline;
    }

    .message {
      text-align: center;
      color: green;
    }

    .error {
      text-align: center;
      color: red;
    }
  </style>
</head>
<body>

	<!-- This imports the NavBar into the page -->
	<jsp:include page="Navbar.jsp" flush="true"></jsp:include>

	<div class="container">
		<h2>Forgot Password</h2>
		
		<form method="post" action="ForgotServlet">
    		<label for="email">Enter your email address:</label>
    		<input type="email" name="email" required />
    		<input type="submit" value="Send Reset Instructions" />
		</form>

		<% if (request.getAttribute("message") != null) { %>
  			<div class="message"><%= request.getAttribute("message") %></div>
		<% } else if (request.getAttribute("error") != null) { %>
  			<div class="error"><%= request.getAttribute("error") %></div>
		<% } %>

		<div class="back">
		    <a href="login.jsp">Back to Login</a>
		</div>

	</div>
	
	<!-- This imports the Footer into the page below everything -->
	<jsp:include page="Foot.jsp" flush="true"></jsp:include>

</body>
</html>
