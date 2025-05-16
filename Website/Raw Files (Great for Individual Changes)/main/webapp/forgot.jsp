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

  <!-- Google Fonts for styling -->
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500&family=Open+Sans&display=swap" rel="stylesheet">

  <!-- Inline styles for layout, visual hierarchy, and responsiveness -->
  <style>
    /* Universal reset for spacing and layout */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    /* Base body styling */
    body {
      font-family: 'Open Sans', sans-serif;
      background-color: #B4CFEC; /* Soft blue background */
      color: #2c3e50; /* Dark text for contrast */
    }

    /* Main container styling for the form */
    .container {
      width: 90%;
      max-width: 400px;
      margin: 10% auto 11%;
      background-color: white;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    /* Page heading */
    h2 {
      text-align: center;
      margin-bottom: 25px;
    }

    /* Form label styling */
    label {
      display: block;
      margin-bottom: 8px;
    }

    /* Email input styling */
    input[type="email"] {
      width: 100%;
      padding: 10px;
      font-size: 16px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 6px;
    }

    /* Submit button styling */
    input[type="submit"] {
      width: 100%;
      background-color: #54d3f0;
      border: none;
      color: black;
      font-size: 16px;
      padding: 10px;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover {
      background-color: #3bbdd9;
    }

    /* Link back to login */
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

    /* Feedback messages */
    .message {
      text-align: center;
      color: green;
      margin-top: 15px;
    }

    .error {
      text-align: center;
      color: red;
      margin-top: 15px;
    }

    /* Expanded layout for ultra-wide screens */
    @media (min-width: 1920px) {
      .container {
        max-width: 600px;
      }
    }
    
        /* Tablet and mobile responsiveness */
    @media (max-width: 768px) {
      .container {
        margin: 20% auto;
        padding: 25px;
      }

      h2 {
        font-size: 1.4rem;
      }

      input[type="email"], input[type="submit"] {
        font-size: 0.95rem;
        padding: 10px;
      }
    }

    /* For very small phones */
    @media (max-width: 480px) {
      .container {
        margin: 25% auto;
        padding: 20px;
      }

      h2 {
        font-size: 1.2rem;
      }

      input[type="submit"] {
        padding: 10px;
        font-size: 0.9rem;
      }
    
  </style>
</head>
<body>

  <!-- Shared site navigation bar -->
  <jsp:include page="Navbar.jsp" flush="true"></jsp:include>

  <!-- Forgot password form area -->
  <div class="container">
    <h2>Forgot Password</h2>

    <!-- Form to submit email for password reset instructions -->
    <form method="post" action="ForgotServlet">
      <label for="email">Enter your email address:</label>
      <input type="email" name="email" id="email" required />
      <input type="submit" value="Send Reset Instructions" />
    </form>

    <!-- Server-side feedback messages -->
    <% if (request.getAttribute("message") != null) { %>
      <div class="message"><%= request.getAttribute("message") %></div>
    <% } else if (request.getAttribute("error") != null) { %>
      <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>

    <!-- Link to return to login screen -->
    <div class="back">
      <a href="login.jsp">Back to Login</a>
    </div>
  </div>

  <!-- Shared site footer -->
  <jsp:include page="Foot.jsp" flush="true"></jsp:include>

</body>
</html>
