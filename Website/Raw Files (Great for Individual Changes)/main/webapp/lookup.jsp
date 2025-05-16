<!-- 
    Look Up Page - Alpha Team
    Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh

    Purpose:
    This page allows users to look up their reservation by providing either a confirmation number or an email address.
    It submits the data to LookupReservationServlet, which handles the validation and lookup logic using a JOIN 
    between reservations and users. If an error is encountered (e.g., no match or email mismatch), it is displayed here.
-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Look Up Reservation</title>

    <!-- Google Font for consistent typography -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">

    <!-- Internal styles for layout and responsiveness -->
    <style>
		/* Ensure the page takes up the full viewport height and removes default spacing */
		html, body {
    		height: 100%;    /* Full height to support full-background color */
    		margin: 0;       /* Remove default margin */
    		padding: 0;      /* Remove default padding */
		}

		/* Apply base font and background styling to the entire body */
		body {
		    font-family: 'Open Sans', sans-serif;  /* Clean and modern font */
    		background-color: #B4CFEC;             /* Pale blue background for a calming look */
    		color: #2c3e50;                        /* Dark gray text for good contrast */
		}

        /* Main container for form and results */
        .container {
            background: white;
            padding: 100px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 100%;
            max-width: 1000px;
            margin: 10% auto;
        }

        /* Header title */
        h2 {
            margin-bottom: 10px;
        }

        /* Subtext description */
        p.note {
            font-size: 14px;
            color: #666;
            margin-bottom: 25px;
        }

        /* Form inputs for text and email */
        input[type="text"],
        input[type="email"] {
            width: 90%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        /* Submit button */
        input[type="submit"] {
            background-color: #0077cc;
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        /* Hover effect on submit button */
        input[type="submit"]:hover {
            background-color: #005fa3;
        }

        /* Error message styling */
        .error {
            color: red;
            margin-top: 10px;
        }

        /* Reservation table styling */
        #lookupDetails table,
        #lookupDetails th,
        #lookupDetails td {
            border: none;
        }

        #lookupDetails th, td {
            padding: 10px 20px;
            text-align: center;
        }

        #lookupDetails table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
        }

        #lookupDetails h2 {
            text-align: left;
            font-size: 20px;
            color: #333;
        }

        #lookupDetails {
            margin-top: 40px;
            margin-left: -30px;
        }

        /* Small screen adjustments (phones, tablets) */
        @media (max-width: 768px) {
            .container {
                padding: 30px;
            }

            input[type="text"],
            input[type="email"] {
                width: 100%;
            }

            #lookupDetails {
                margin-left: 0;
            }
        }

        /* Ultra-wide screen support (large desktops, 2K+) */
        @media (min-width: 1920px) {
            .container {
                max-width: 1400px;
                padding: 80px 100px;
            }

            input[type="text"],
            input[type="email"] {
                width: 60%;
                font-size: 16px;
            }

            input[type="submit"] {
                font-size: 16px;
                padding: 12px 30px;
            }

            #lookupDetails table {
                font-size: 18px;
            }
        }
    </style>
</head>

<body>

    <!-- Shared site-wide navigation bar -->
    <jsp:include page="Navbar.jsp" flush="true"></jsp:include>

    <!-- Main reservation lookup form container -->
    <div class="container">
        <h2>Look Up Your Reservation</h2>
        <p class="note">Enter your confirmation number or email — only one is required.</p>

        <!-- Form sends user input to LookupReservationServlet -->
        <form action="LookupReservationServlet" method="post">
            <input type="text" name="confirmationNumber" placeholder="Confirmation Number"><br>
            <input type="email" name="email" placeholder="Email"><br>
            <input type="submit" value="Look Up Reservation">
        </form>

        <!-- Display error if set by servlet -->
        <% 
            String error = (String) request.getAttribute("error");
            if (error != null) { 
        %>
            <div class="error"><%= error %></div>
        <% } %>

        <!-- Display matching reservation(s) returned from servlet -->
        <div id="lookupDetails">
            <%  
                List<Map<String, Object>> reservations = (List<Map<String, Object>>) request.getAttribute("reservations");
                if (reservations != null && !reservations.isEmpty()) {
            %>

            <h2>Your Stays:</h2>
            <div id="details">
                <table>
                    <tr>
                        <th>Confirmation Number</th>
                        <th>Room</th>
                        <th>Guests</th>
                        <th>Check In</th>
                        <th>Check Out</th>
                        <th>Total</th>
                    </tr>
                    <% for (Map<String, Object> res : reservations) { %>
                        <tr>
                            <td><%= res.get("confirmationNumber") %></td>
                            <td><%= res.get("roomName") %></td>
                            <td><%= res.get("numOfGuests") %></td>
                            <td><%= res.get("checkInDate") %></td>
                            <td><%= res.get("checkOutDate") %></td>
                            <td><%= res.get("totalCost") %></td>
                        </tr>
                    <% } %>
                </table>
            </div>
            <% } %>
        </div>
    </div>

    <!-- Shared footer across all pages -->
    <jsp:include page="Foot.jsp" flush="true"></jsp:include>

</body>
</html>
