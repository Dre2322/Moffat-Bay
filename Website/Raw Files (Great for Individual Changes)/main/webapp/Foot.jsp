<!-- Footer Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->
<%@page language="java" contentType="text/html"%>
<% String base = (String)application.getAttribute("base"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="description" content="Footer Page">
    <meta name="keywords" content="HTML, JSP, CSS">
    <meta name="author" content="Andres Melendez, Jeffrey Reid">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500&family=Open+Sans&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/6af38ce6e0.js" crossorigin="anonymous"></script>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Open Sans', sans-serif;
            color: #2c3e50;
        }

        footer {
            background-color: rgb(16, 128, 153);
            text-align: center;
            padding: 5rem 3rem;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            font-size: 1.2em;
            position: relative;
            bottom: 0;
            width: 100%;
        }

        footer a {
            color: black;
            text-decoration: underline;
            margin: 0 15px;
        }

        footer a i {
            margin-right: 6px;
        }

        footer a:hover {
            text-decoration: none;
            color: black;
        }
    </style>
</head>

<body>
    <footer>
        <a href="aboutus.jsp"><i class="fas fa-user"></i>About Us</a> |
        <!-- Why is this here? This is on the NavBar -->
        <a href="lookup.jsp"><i class="fas fa-search"></i>Look Up Reservation</a>
    </footer>
</body>
</html>
