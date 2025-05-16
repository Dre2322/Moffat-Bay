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
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">

  <style>
    /* ==== Base Styles ==== */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Open Sans', sans-serif;
      background-color: #B4CFEC;
      color: #2c3e50;
    }

    /* ==== Container Box ==== */
    .container {
      background-color: white;
      width: 90%;
      max-width: 400px;
      margin: 10% auto;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    h2 {
      text-align: center;
      margin-bottom: 25px;
      font-size: 24px;
    }

    label {
      display: block;
      margin-bottom: 8px;
      font-weight: 600;
    }

    input[type="password"],
    input[type="submit"] {
      width: 100%;
      padding: 12px;
      font-size: 16px;
      margin-top: 12px;
      border-radius: 6px;
      border: 1px solid #ccc;
    }

    input[type="submit"] {
      background-color: #54d3f0;
      border: none;
      color: black;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover {
      background-color: #45b8d8;
    }

    /* ==== Feedback Message Styling ==== */
    .message,
    .error {
      text-align: center;
      margin-top: 20px;
      font-size: 15px;
    }

    .message {
      color: green;
    }

    .error {
      color: red;
    }

    .message a {
      color: #007BFF;
      text-decoration: none;
    }

    .message a:hover {
      text-decoration: underline;
    }

    /* ==== Responsive for Tablets and Phones ==== */
    @media (max-width: 768px) {
      .container {
        margin: 15% auto;
        padding: 25px 20px;
      }

      h2 {
        font-size: 20px;
      }

      input[type="password"],
      input[type="submit"] {
        font-size: 15px;
        padding: 10px;
      }
    }

    /* ==== Responsive for Ultra-Wide Screens ==== */
    @media (min-width: 1920px) {
      .container {
        max-width: 600px;
        padding: 40px;
      }

      h2 {
        font-size: 28px;
      }

      input[type="password"],
      input[type="submit"] {
        font-size: 18px;
        padding: 14px;
      }
    }
  </style>
</head>

<body>

  <!-- Global Navigation -->
  <jsp:include page="Navbar.jsp" flush="true" />

  <!-- Password Reset Container -->
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
        <a href="login.jsp">Click here to log in</a>
      </div>
    <% } else if (request.getAttribute("error") != null) { %>
      <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>
  </div>

  <!-- Global Footer -->
  <jsp:include page="Foot.jsp" flush="true" />

</body>
</html>
