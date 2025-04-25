<!-- NavBar Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="description" content="NavBar Page">
    <meta name="keywords" content="HTML, JSP, CSS">
    <meta name="author" content="Andres Melendez, Jeffrey Reid, Jordany Gonzalez">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500&family=Open+Sans&display=swap" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Pacifico' rel='stylesheet'>
    
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

        /* ======= NAVBAR ======= */
		.navbar {
		    /*position: fixed;    DO NOT UNCOMMENT THIS. THE NAVBAR SHOULD NOT BE FIXED!!!*/
		    top: 0;
		    left: 0;
		    width: 100%; /* <-- ensures it stretches full width */
		    display: flex;
		    align-items: center;
		    justify-content: space-between;
		    background-color: #14c2e9;
		    padding: 1.3rem 3rem;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		    z-index: 1000; /* optional, ensures it's above other elements */		    
		}

        .navbar-left a {
            text-decoration: none;
            color: #000;
            transition: all 0.2s ease;
            cursor: pointer;
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

        /* Center Nav Links */
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
            cursor: pointer;
        }

        .navbar-center a:hover {
            color: #0056b3;
            text-decoration: underline;
        }

        /* Auth Buttons (Login/Signup or My Account/Logout) */
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
            background-color: #000;
            color: white;
        }

        /* Logout Button */
        .navlogout {
            padding: 0.5rem 1rem;
            border: 2px solid #000;
            border-radius: 5px;
            text-decoration: none;
            color: black;
            font-weight: bold;
            transition: all 0.2s ease;
            background-color: #14c2e9;
            font-family: 'Open Sans', sans-serif;
            font-weight: bold;
            font-size: 1em;
        }

        .navlogout:hover {
            background-color: #000;
            color: white;
            cursor: pointer;
        }

        /* ======= RESPONSIVE ======= */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
            }

            /* Hide desktop links on mobile */
            .navbar-center {
                display: none; /* Hide links on mobile */
            }

            .navbar-right {
                display: none; /* Hide auth buttons on mobile */
            }

            /* Show hamburger icon for mobile */
            .navbar-toggle {
                display: block;
                cursor: pointer;
                font-size: 30px;
                margin-left: auto;
            }

            /* Mobile Links */
            .navbar-mobile {
                display: none;
                width: 100%;
                flex-direction: column;
                text-align: left;
            }

            /* Show mobile menu when active */
            .navbar-mobile.active {
                display: flex;
            }
        }

        /* ======= Desktop View ======= */
        @media (min-width: 769px) {
            /* Hide mobile elements on desktop */
            .navbar-toggle {
                display: none;
            }

            .navbar-mobile {
                display: none;
            }
        }
    </style>
</head>

<body>
    <!-- Navbar -->
    <header>
        <div class="navbar">
            <!-- Logo Section -->
            <div class="navbar-left">
                <a href="index.jsp">
                    <h1>Moffat Bay Lodge</h1>
                </a>
            </div>

            <!-- Navigation Links for Desktop -->
            <div class="navbar-center">
                <a href="attraction.jsp">Attractions</a>
                <a href="reservation.jsp">Reservations</a>
                <a href="lookup.jsp">My Reservation</a>
            </div>

            <!-- Auth Buttons -->
            <div class="navbar-right" id="authArea">
                <%-- Dynamically show login/logout button --%>
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

            <!-- Hamburger Icon for Mobile -->
            <div class="navbar-toggle" onclick="toggleNavbar()">☰</div>

            <!-- Mobile Navigation Menu -->
            <div class="navbar-mobile">
                <a href="attraction.jsp">Attractions</a>
                <a href="reservation.jsp">Reservations</a>
                <a href="lookup.jsp">My Reservation</a>
            </div>
        </div>
    </header>

    <script>
        // Function to toggle mobile navbar visibility
        function toggleNavbar() {
            const menu = document.querySelector('.navbar-mobile');
            menu.classList.toggle('active');
        }
    </script>
</body>
</html>
