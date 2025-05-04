<!-- Registration Confirmation Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->

<!-- Purpose:
This page displays a confirmation message to the user after successfully registering an account.
It welcomes the user, showing their first name if available, and provides a button to navigate to the homepage.
The background and layout are designed to enhance the user experience with a visually pleasing and clear
confirmation message. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Confirmation Page">
    <meta name="keywords" content="HTML, JSP, CSS">
    <meta name="author" content="Alpha Team">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache">
    <title>Registration Confirmation</title>

    <style>
        @charset "UTF-8";

        body {
            background: url('https://images.unsplash.com/photo-1506744038136-46273834b3fb') no-repeat center center/cover;
            font-family: 'Open Sans', sans-serif;
            margin: 0;
            padding: 0;
        }

        #confirm {
            text-align: center;
            margin: 100px auto;
            padding: 100px 40px;
            max-width: 600px;
            font-size: 1.5em;
            background-color: azure;
            border: 2px solid #000;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }

        .confirmtohome {
            font-size: 0.8em;
            margin-top: 20px;
        }

        .confirmtohome a,
        .home-btn {
            font-size: 1em;
            padding: 12px 24px;
            margin-top: 30px;
            background-color: #14c2e9;
            color: black;
            border: 2px solid #000;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
            display: inline-block;
        }

        .confirmtohome a:hover,
        .home-btn:hover {
            background-color: black;
            color: white;
        }

        @media screen and (max-width: 768px) {
            #confirm {
                margin: 50px 20px;
                padding: 60px 20px;
                font-size: 1.2em;
            }

            .confirmtohome {
                font-size: 0.9em;
            }
        }

        @media screen and (min-width: 1921px) {
            #confirm {
                margin: 7.2% auto;
            }
        }
    </style>
</head>
<body>

    <!-- Include shared navigation -->
    <jsp:include page="Navbar.jsp" flush="true" />

    <div id="confirm">
        <h1>Registration Successful!</h1>
        <p>Your account has been created successfully.</p>

        <%
            String username = (String) session.getAttribute("first_name");
            if (username != null) {
        %>
            <p>Welcome, <strong><%= username %></strong>!</p>
        <%
            }
        %>

        <p class="confirmtohome">You can now log in and start exploring Moffat Bay Lodge.</p>

        <a class="home-btn" href="index.jsp">Go to Homepage</a>
    </div>

    <!-- Include shared footer -->
    <jsp:include page="Foot.jsp" flush="true" />

</body>
</html>
