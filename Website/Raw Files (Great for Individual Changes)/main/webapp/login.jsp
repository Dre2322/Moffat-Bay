<!-- Login Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    String redirect = request.getParameter("redirect");
    String message = request.getParameter("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="author" content="Jordany Gonzalez, Jeffrey Reid, Andres Melendez">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Login - Moffat Bay Lodge</title>
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
      max-width: 400px;
      margin: 120px auto 160px;
      background-color: white;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    .container h2 {
      text-align: center;
      margin-bottom: 25px;
    }

    .info {
      color: #007BFF;
      text-align: center;
      margin-bottom: 15px;
      font-size: 14px;
    }

    .form-group {
      margin-bottom: 15px;
    }

    .form-group input {
      width: 100%;
      padding: 10px;
      font-size: 16px;
      margin-top: 5px;
    }

    .form-actions {
      text-align: right;
      margin-bottom: 10px;
    }

    .form-actions a {
      font-size: 14px;
      text-decoration: none;
      color: #007BFF;
    }

    .form-actions a:hover {
      text-decoration: underline;
    }

    .submit-btn {
      width: 100%;
      background-color: #54d3f0;
      border: none;
      color: black;
      font-size: 16px;
      padding: 10px;
      margin-top: 20px;
      cursor: pointer;
      border-radius: 8px;
    }

    .signup-link {
      text-align: center;
      margin-top: 20px;
      font-size: 14px;
    }

    .signup-link a {
      color: #007BFF;
      text-decoration: none;
    }

    .signup-link a:hover {
      text-decoration: underline;
    }

    .error {
      color: red;
      text-align: center;
      margin-top: 10px;
    }
  </style>
</head>
<body>

  <jsp:include page="Navbar.jsp" flush="true" />

  <div class="container">
    <h2>Login to Your Account</h2>

    <% if ("confirmReservation".equals(redirect)) { %>
      <div class="info">Please log in to confirm your reservation.</div>
    <% } else if ("registered".equals(message)) { %>
      <div class="info">✅ Registration successful! Please log in.</div>
    <% } %>

    <form method="post" action="LoginServlet" autocomplete="off">
      <div class="form-group">
        <label>Email:</label>
        <input type="email" name="email" required />
      </div>
      <div class="form-group">
        <label>Password:</label>
        <input type="password" name="password" required />
      </div>

      <input type="hidden" name="redirect" value="<%= (redirect != null) ? redirect : "" %>" />

      <div class="form-actions">
        <a href="forgot.jsp">Forgot password?</a>
      </div>

      <input type="submit" value="Login" class="submit-btn" />

      <div class="signup-link">
        Don't have an account? 
        <a href="RegistrationPage.jsp<%= (redirect != null ? ("?redirect=" + redirect) : "") %>">Sign up here</a>
      </div>
    </form>

    <p class="error">
      <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
    </p>
  </div>

  <jsp:include page="Foot.jsp" flush="true" />

</body>
</html>
