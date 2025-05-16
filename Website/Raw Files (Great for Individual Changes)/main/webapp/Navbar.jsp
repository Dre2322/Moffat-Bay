<!-- NavBar Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->

<!-- Purpose:
This page defines the navigation bar (NavBar) for the Moffat Bay Lodge website. It includes the logo section,
navigation links (such as Attractions, Reservations, and My Reservation), and authentication buttons
(Login/Sign Up or Logout) based on whether the user is logged in. The navigation bar is designed to be responsive,
with mobile support for a hamburger menu and collapsible links. It provides a consistent, user-friendly interface
for users to navigate through the site. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="description" content="NavBar Page">
    <meta name="keywords" content="HTML, JSP, CSS">
    <meta name="author" content="Andres Melendez, Jeffrey Reid, Jordany Gonzalez">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500&family=Open+Sans&display=swap" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Pacifico' rel='stylesheet'>

    <!-- FontAwesome Icons -->
    <script src="https://kit.fontawesome.com/6af38ce6e0.js" crossorigin="anonymous"></script>

    <style>
        /* Reset and base styling */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Open Sans', sans-serif;
            color: #2c3e50;
        }

        /* ======= NAVBAR WRAPPER ======= */
        .navbar {
            width: 100%;
            display: flex;
            justify-content: center; /* centers the inner navbar on ultrawide screens */
            background-color: #14c2e9;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 1.3rem 0;
            z-index: 1000;
        }

        /* ======= INNER CONTAINER FOR CONTENT ======= */
        .navbar-inner {
            width: 100%;
            max-width: 1440px; /* keeps content readable on ultra-wide screens */
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 3rem;
        }

        /* ======= LEFT (Logo) ======= */
        .navbar-left a {
            text-decoration: none;
            color: #000;
            transition: all 0.2s ease;
        }

        .navbar-left a:hover {
            color: #0056b3;
            text-decoration: underline;
        }

        .navbar-left h1 {
            font-family: 'Pacifico';
            font-size: 2rem;
            color: black;
            margin: 0;
        }

        /* ======= CENTER LINKS ======= */
        .navbar-center {
            display: flex;
            justify-content: center;
            gap: 2rem;
            flex: 1;
        }

        .navbar-center a {
            text-decoration: none;
            color: black;
            font-weight: 600;
            font-size: 1rem;
        }

        .navbar-center a:hover {
            color: #0056b3;
            text-decoration: underline;
        }

        /* ======= RIGHT (Auth Buttons) ======= */
        .navbar-right {
            display: flex;
            gap: 1rem;
        }

        .auth-button {
            padding: 0.5rem 1rem;
            border: 2px solid #000;
            border-radius: 5px;
            text-decoration: none;
            color: black;
            font-weight: bold;
            transition: all 0.2s ease;
        }

        .auth-button:hover {
            background-color: #fff;
            color: #000;
            border-color: #000;
        }

        .navlogout {
            padding: 0.5rem 1rem;
            border: 2px solid #000;
            border-radius: 5px;
            background-color: #14c2e9;
            font-family: 'Open Sans', sans-serif;
            font-weight: bold;
            font-size: 1em;
            color: black;
            transition: all 0.2s ease;
        }

        .navlogout:hover {
            background-color: #000;
            color: white;
            cursor: pointer;
        }

        /* ======= MOBILE STYLES ======= */
        @media (max-width: 768px) {
            .navbar-inner {
                flex-direction: column;
                align-items: flex-start;
            }

            .navbar-center {
                display: none; /* hide links on small screens */
            }

            .navbar-right {
                display: none; /* hide buttons on small screens */
            }

            .navbar-toggle {
                display: block;
                cursor: pointer;
                font-size: 30px;
                margin-left: auto;
            }

            .navbar-mobile {
                display: none;
                flex-direction: column;
                width: 100%;
                padding: 1rem 3rem;
                background-color: #14c2e9;
            }

            .navbar-mobile a {
                text-decoration: none;
                color: black;
                margin-bottom: 1rem;
                font-weight: bold;
            }

            .navbar-mobile a:hover {
                text-decoration: underline;
                color: #0056b3;
            }

            .navbar-mobile.active {
                display: flex;
            }
        }

        /* Hide mobile elements on desktop */
        @media (min-width: 769px) {
            .navbar-toggle,
            .navbar-mobile {
                display: none;
            }
        }
    </style>
</head>

<body>
    <!-- ======= NAVIGATION HEADER ======= -->
    <header>
        <div class="navbar">
            <div class="navbar-inner">
                <!-- Logo / Home -->
                <div class="navbar-left">
                    <a href="index.jsp">
                        <h1>Moffat Bay Lodge</h1>
                    </a>
                </div>

                <!-- Main nav links (desktop) -->
                <div class="navbar-center">
                    <a href="attractions.jsp">Attractions</a>
                    <a href="reservation.jsp">Reservations</a>
                    <a href="lookup.jsp">My Reservation</a>
                </div>

                <!-- Login / Signup or Welcome / Logout -->
                <div class="navbar-right" id="authArea">
                    <% 
                        String firstName = (String) session.getAttribute("first_name");
                        if (session.getAttribute("user_id") == null) {
                    %>
                        <a href="login.jsp" class="auth-button">Login</a>
                        <a href="RegistrationPage.jsp" class="auth-button">Sign Up</a>
                    <% 
                        } else { 
                    %>
                        <span style="align-self: center; font-weight: bold;">
                            Welcome, <%= firstName %>
                        </span>
                        <form method="post" action="LogoutServlet">
                            <input class="navlogout" type="submit" value="Logout">
                        </form>
                    <% 
                        }
                    %>
                </div>

                <!-- Hamburger menu icon (mobile) -->
                <div class="navbar-toggle" onclick="toggleNavbar()">☰</div>
            </div>

            <!-- Mobile navigation links -->
            <div class="navbar-mobile">
                <a href="attractions.jsp">Attractions</a>
                <a href="reservation.jsp">Reservations</a>
                <a href="lookup.jsp">My Reservation</a>
            </div>
        </div>
    </header>

    <script>
        // Toggle mobile menu visibility
        function toggleNavbar() {
            const menu = document.querySelector('.navbar-mobile');
            menu.classList.toggle('active');
        }
    </script>
</body>
</html>
