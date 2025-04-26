<!-- Reservation Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->

<!-- Purpose:
This page allows users to make a reservation at Moffat Bay Lodge by selecting their check-in and check-out dates.
Upon submitting the form, the page sends the date range to the `ReservationServlet`, which handles the logic of
checking room availability. The page is styled to be user-friendly, with responsive design adjustments for different
screen sizes, ensuring a seamless experience on both desktop and mobile devices. The form also includes error message
handling to provide feedback to the user. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="author" content="Matthew Trinh, Andres Melendez">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Reservation Page</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500&family=Open+Sans&display=swap" rel="stylesheet">
	<style>
	    /* Global Styling */
	    * {
	        margin: 0;
	        padding: 0;
	        box-sizing: border-box;
	    }

	    body {
	        font-family: 'Open Sans', sans-serif;
	        color: #2c3e50;
	        background-color: #f9f9f9;
	        display: flex;
	        justify-content: center;
	        align-items: flex-start; /* Align content to top */
	        height: 100%;
	        padding-top: 60px; /* Adds space between the header and form */
	    }
	
	    /* Container Styling */
	    .container {
	        max-width: 500px;
	        width: 100%;
	        background-color: white;
	        padding: 40px;
	        border-radius: 12px;
	        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
	        text-align: center;
	        margin-top: 50px; /* Adds space between the navbar and form */
	    }
	
	    .container h2 {
	        margin-bottom: 30px;
	        font-size: 24px;
	        color: #333;
	        font-weight: 600;
	    }

	    /* Form Styling */
	    .form-group {
	        margin-bottom: 20px;
	        text-align: left;
	    }
	
	    label {
	        font-weight: bold;
	        display: block;
	        margin-bottom: 8px;
	        color: #555;
	    }
	
	    /* Date Input Styling */
	    input[type="date"] {
	        width: 100%;
	        padding: 12px;
	        font-size: 16px;
	        border: 2px solid #ddd;
	        border-radius: 8px;
	        margin-top: 8px;
	        background-color: #f9f9f9;
	        transition: border 0.3s ease;
	    }
	
	    input[type="date"]:focus {
	        border-color: #54d3f0;
	    }
	
	    /* Submit Button Styling */
	    .submit-btn {
	        width: 100%;
	        padding: 12px;
	        background-color: #54d3f0;
	        border: none;
	        color: white;
	        font-size: 18px;
	        border-radius: 8px;
	        cursor: pointer;
	        transition: background-color 0.3s ease;
	    }

	    .submit-btn:hover {
	        background-color: #45b8d8;
	    }
	
	    /* Error Message Styling */
	    .error {
	        color: red;
	        font-size: 14px;
	        margin-top: 20px;
	    }
	
	    /* ======= RESPONSIVE DESIGN ======= */
	    @media (max-width: 768px) {
	        /* Adjust container width on small screens */
	        .container {
	            padding: 20px;
	        }
	
	        /* Adjust form inputs for smaller screens */
	        input[type="date"] {
	            font-size: 14px;
	        }

	        .submit-btn {
	            font-size: 16px;
	        }
	    }
	</style>
</head>
<body>

    <!-- Main Content (Reservation Form) -->
    <div class="container">
        <h2>Make a Reservation</h2>
        
        <form method="post" action="ReservationServlet">
            <input type="hidden" name="action" value="selectRoom">
            <div class="form-group">
                <label for="startDate">Check-in Date:</label>
                <input type="date" name="startDate" id="startDate" required><br/>
            </div>
            
            <div class="form-group">
                <label for="endDate">Check-out Date:</label>
                <input type="date" name="endDate" id="endDate" required><br/>
            </div>
            
            <input type="submit" class="submit-btn" value="Search Available Rooms">
        </form>
        
        <p class="error">
            <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
        </p>
    </div>

</body>
</html>
