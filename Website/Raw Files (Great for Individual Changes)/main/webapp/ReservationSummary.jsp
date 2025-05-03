<!--
Reservation Summary Page - Alpha Team
Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh

Purpose:
Displays reservation confirmation details after submission or lookup. Includes:
- Summary of check-in, check-out, guest count, room types, and cost
- Logic to allow editing if the user is logged in
- Redirect to homepage if accessed without valid session context
-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Ensure session data is valid, otherwise redirect
    if (request.getAttribute("confirmationNumber") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Determine login status from session
    HttpSession activeSession = request.getSession(false);
    boolean isLoggedIn = activeSession != null && activeSession.getAttribute("user_id") != null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Reservation Summary</title>
  <link rel="stylesheet" href="reservationsummary.css" />
</head>
<body>

  <!-- Reuse site-wide navigation -->
  <jsp:include page="Navbar.jsp" flush="true" />

  <main>
    <div class="card">
      <h2>Booking Confirmation</h2>
      <h3>Booking Details</h3>

      <!-- Confirmation ID shown prominently -->
      <p style="text-align: center; font-size: 16px;">
        Confirmation Number: <strong><%= request.getAttribute("confirmationNumber") %></strong>
      </p>

      <!-- Core reservation fields -->
      <div class="summary-row">
        <div class="summary-item">
          <p>Check-In:</p>
          <strong><%= request.getAttribute("checkInDate") %></strong>
        </div>
        <div class="summary-item">
          <p>Check-Out:</p>
          <strong><%= request.getAttribute("checkOutDate") %></strong>
        </div>
        <div class="summary-item">
          <p>Guests:</p>
          <strong><%= request.getAttribute("numOfGuests") %></strong>
        </div>
        <div class="summary-item">
          <p>Rooms:</p>
          <strong><%= request.getAttribute("roomCount") != null ? request.getAttribute("roomCount") : "N/A" %></strong>
        </div>
        <div class="summary-item">
          <p>Total Cost:</p>
          <strong>$<%= request.getAttribute("totalCost") %></strong>
        </div>
      </div>

      <!-- Room types and optional notes -->
      <div class="room-details">
        Room Details: 
        <strong><%= request.getAttribute("roomDetails") != null ? request.getAttribute("roomDetails") : "No room details available" %></strong>
      </div>

      <% if (request.getAttribute("specialRequests") != null) { %>
        <div class="room-details">
          Special Requests: <strong><%= request.getAttribute("specialRequests") %></strong>
        </div>
      <% } %>

      <!-- Confirmation buttons -->
      <form method="post" action="resConfirmation.jsp">
        <div class="buttons">
          <button id="cancelbtn" type="button" onclick="location.href='index.jsp'">Cancel</button>
          <button id="submitbtn" type="submit">Submit</button>
        </div>
      </form>

      <!-- Edit option only shown to logged-in users -->
      <% if (isLoggedIn) { %>
        <form method="post" action="ReservationServlet">
          <input type="hidden" name="action" value="editReservation">
          <input type="hidden" name="checkInDate" value="<%= request.getAttribute("checkInDate") %>" />
          <input type="hidden" name="checkOutDate" value="<%= request.getAttribute("checkOutDate") %>" />
          <input type="hidden" name="numGuests" value="<%= request.getAttribute("numOfGuests") %>" />
          <input type="hidden" name="roomDetails" value="<%= request.getAttribute("roomDetails") %>" />
          <input type="hidden" name="roomCount" value="<%= request.getAttribute("roomCount") %>" />
          <input type="hidden" name="reservationId" value="<%= request.getAttribute("reservationId") != null ? request.getAttribute("reservationId") : "" %>" />
          <div class="buttons" style="margin-top: 10px;">
            <button id="editbtn" type="submit">Edit</button>
          </div>
        </form>
      <% } else { %>
        <div class="login-reminder">
          Login to edit your reservation. <a href="login.jsp">Go to Login</a>
        </div>
      <% } %>
    </div>
  </main>

  <!-- Reuse site-wide footer -->
  <jsp:include page="Foot.jsp" flush="true" />

</body>
</html>
