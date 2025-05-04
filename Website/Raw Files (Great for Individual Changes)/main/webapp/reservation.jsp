<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<!-- 
  Reservation Page - Alpha Team
  Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh

  Purpose:
  This page allows users to make a reservation at Moffat Bay Lodge by selecting their check-in and check-out dates.
  It passes the selected range to the ReservationServlet, which checks room availability.
  The layout is responsive and styled to match the rest of the website.
-->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="author" content="Alpha Team">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Reservation Page</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500&family=Open+Sans&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="reservation.css">
</head>
<body>

    <!-- Include navigation bar -->
    <jsp:include page="Navbar.jsp" flush="true" />

    <!-- Main Content (Reservation Form) -->
    <main class="reservation-main">
        <div class="container">
            <h2>Make a Reservation</h2>

            <form method="post" action="ReservationServlet" class="reservation-form">
                <input type="hidden" name="action" value="selectRoom">

                <div class="form-group">
                    <label for="startDate">Check-in Date:</label>
                    <input type="date" name="startDate" id="startDate" required>
                </div>

                <div class="form-group">
                    <label for="endDate">Check-out Date:</label>
                    <input type="date" name="endDate" id="endDate" required>
                </div>

                <input type="submit" class="submit-btn" value="Search Available Rooms">
            </form>

            <p class="error">
                <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
            </p>
        </div>
    </main>

    <!-- Footer -->
    <jsp:include page="Foot.jsp" flush="true" />

</body>
</html>
