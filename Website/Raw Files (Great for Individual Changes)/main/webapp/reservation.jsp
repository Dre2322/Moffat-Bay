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
    <!-- Meta Tags: Define character encoding, author, and viewport settings for responsiveness -->
    <meta charset="UTF-8" />
    <meta name="author" content="Alpha Team">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- Title of the page -->
    <title>Reservation Page</title>

    <!-- Linking Google Fonts for styling the page with 'Playfair Display' and 'Open Sans' -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500&family=Open+Sans&display=swap" rel="stylesheet">

    <!-- Link to external stylesheet for the reservation page -->
    <link rel="stylesheet" href="reservation.css">

    <!-- JavaScript to validate date input fields before submitting the form -->
    <script>
        // Date validation to ensure the check-out date is after the check-in date
        document.addEventListener('DOMContentLoaded', function() {
            // Get the form element
            const form = document.querySelector('.reservation-form');

            // Add event listener to the form for the 'submit' event
            form.addEventListener('submit', function(event) {
                // Get the start date (check-in date) and end date (check-out date)
                const startDate = document.getElementById('startDate').value;
                const endDate = document.getElementById('endDate').value;

                // Check if the start date is greater than or equal to the end date
                if (new Date(startDate) >= new Date(endDate)) {
                    // Prevent form submission if the dates are invalid
                    event.preventDefault();
                    // Show an alert message
                    alert('Check-out date must be later than check-in date.');
                }
            });
        });
    </script>
</head>

<body>

    <!-- Include navigation bar (common header for all pages) -->
    <jsp:include page="Navbar.jsp" flush="true" />

    <!-- Main Content: Reservation Form Section -->
    <main class="reservation-main">
        <div class="container">
            <!-- Reservation Page Header -->
            <h2>Make a Reservation</h2>

            <!-- Reservation Form: Form sends data via POST to 'ReservationServlet' -->
            <form method="post" action="ReservationServlet" class="reservation-form">
                <!-- Hidden input to specify the action for the servlet -->
                <input type="hidden" name="action" value="selectRoom">

                <!-- Form Group: Check-in Date Input -->
                <div class="form-group">
                    <label for="startDate">Check-in Date:</label>
                    <!-- Date input for check-in, required field for form submission -->
                    <input type="date" name="startDate" id="startDate" required aria-label="Check-in Date">
                </div>

                <!-- Form Group: Check-out Date Input -->
                <div class="form-group">
                    <label for="endDate">Check-out Date:</label>
                    <!-- Date input for check-out, required field for form submission -->
                    <input type="date" name="endDate" id="endDate" required aria-label="Check-out Date">
                </div>

                <!-- Submit Button to search for available rooms -->
                <input type="submit" class="submit-btn" value="Search Available Rooms">
            </form>

            <!-- Error Message Section: Display any error messages passed from the backend -->
            <p class="error" aria-live="assertive">
                <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
            </p>
        </div>
    </main>

    <!-- Footer: Common footer included for all pages -->
    <jsp:include page="Foot.jsp" flush="true" />

</body>

</html>
