<!-- Footer Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->
<%@page language="java" contentType="text/html"%>
<% String base = (String)application.getAttribute("base"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
  	<meta name="description" content="NavBar Page">
    <meta name="keywords" content="HTML, JSP, CSS">
    <meta name="author" content="Andres Melendez, Jeffrey Reid">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    
    <!-- The idea is that this page is imported into every page that needs it so the code isn't rewritten each time -->
    
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

        /* ======= FOOTER ======= */

        footer {
            background-color:rgb(16, 128, 153);
            text-align: center;
            padding: 5rem 3rem;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            font-size = 1.2em;
            position: relative;
            bottom: 0;
            width: 100%;
        }

        footer a {
            color: black;
            text-decoration: underline;
        }
        
        footer a:hover {
        	text-decoration: none;
        	color: black;
        }

    </style>
    </head>

    <body>
    
    <!-- Footer -->
    <footer>
        <a href="aboutus.jsp"> About Us</a>
    </footer>





</body>
</html>
