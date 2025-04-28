<!-- Footer Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->

<!-- Purpose:
This page defines the footer section of the website. It includes a link to the "About Us" page
and displays a salmon logo for branding, as specifically requested by the client.
The salmon image enhances the site's theme and floats with a smooth animation for visual appeal.
The footer is styled with a background color and shadow for a clean, modern design and provides
consistent navigation across all pages.
-->

<%@page language="java" contentType="text/html"%>
<% 
    // Get the base path of the application from the ServletContext attribute
    String base = (String)application.getAttribute("base");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="description" content="Footer Page" />
    <meta name="keywords" content="HTML, JSP, CSS" />
    <meta name="author" content="Andres Melendez, Jeffrey Reid" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- Link to external Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500&family=Open+Sans&display=swap" rel="stylesheet">
    
    <!-- Link to FontAwesome icons -->
    <script src="https://kit.fontawesome.com/6af38ce6e0.js" crossorigin="anonymous"></script>

    <style>
        /* Reset margins and paddings for all elements */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Apply font and default text color to the body */
        body {
            font-family: 'Open Sans', sans-serif;
            color: #2c3e50;
        }

        /* Footer container styling */
        footer {
            background-color: rgb(16, 128, 153); /* Teal background */
            text-align: center; /* Center content */
            padding: 5rem 3rem; /* Padding for space */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Light shadow */
            font-size: 1.2em;
            position: relative;
            bottom: 0;
            width: 100%;
        }

        /* Footer links styling */
        footer a {
            color: black;
            text-decoration: underline;
            margin: 0 15px;
        }

        /* Icon spacing inside links */
        footer a i {
            margin-right: 6px;
        }

        /* Link hover effect */
        footer a:hover {
            text-decoration: none;
            color: black;
        }

        /* Salmon image styling with animation */
        footer img {
            width: 50px; /* Set image width */
            height: auto; /* Maintain aspect ratio */
            vertical-align: middle; /* Align with text */
            margin-left: 15px; /* Space between link and image */
            animation: float 3s ease-in-out infinite; /* Apply floating animation */
        }

        /* Keyframes for floating animation */
        @keyframes float {
            0% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-10px); /* Float up */
            }
            100% {
                transform: translateY(0px); /* Return to original */
            }
        }
    </style>
</head>

<body>
    <footer>
        <!-- Link to About Us page with user icon -->
        <a href="aboutus.jsp"><i class="fas fa-user"></i>About Us</a> |
        
        <!-- Salmon logo with smooth floating animation -->
        <img src="${pageContext.request.contextPath}/images/SalishSalmon.png" alt="Salmon Logo">
    </footer>
</body>
</html>
