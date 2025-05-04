<!-- 
Reset Password Page - Alpha Team
Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh

Purpose:
This page allows users to reset their password by submitting a new one along with a valid reset token
provided via a password reset email. It retrieves the token from the query string and includes it as a hidden 
form field. The form sends the data to the ResetServlet, which validates the token and updates the password 
in the database. Upon completion, the user is shown a success or error message.
-->

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Reset Password - Moffat Bay Lodge</title>
  <style>
    body {
      font-family: 'Open Sans', sans-serif;
      background-color: #f2f2f2;
    }
    .container {
      width: 400px;
      margin: 10% auto;
      background-color: #fff;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    h2 {
      text-align: center;
    }
    input[type="password"], input[type="submit"] {
      width: 100%;
      padding: 10px;
      margin-top: 15px;
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
  <h2>Reset Password</h2>
  <form method="post" action="ResetServlet">
    <input type="hidden" name="token" value="<%= request.getParameter("token") %>" />
    <label>New Password:</label>
    <input type="password" name="password" required />
    <input type="submit" value="Reset Password" />
  </form>

  <% if (request.getAttribute("message") != null) { %>
    <div class="message">
      <%= request.getAttribute("message") %><br><br>
      <a href="login.jsp" style="color: #007BFF; text-decoration: none;">Click here to log in</a>
    </div>
  <% } else if (request.getAttribute("error") != null) { %>
    <div class="error"><%= request.getAttribute("error") %></div>
  <% } %>
</div>

<!-- Footer -->
<jsp:include page="Foot.jsp" flush="true" />

</body>
</html>
