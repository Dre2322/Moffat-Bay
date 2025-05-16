<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  // Prevent direct access to the summary page without valid data
  if (request.getAttribute("confirmationNumber") == null) {
      response.sendRedirect("index.jsp");
      return;
  }
  HttpSession activeSession = request.getSession(false);
  boolean isLoggedIn = activeSession != null && activeSession.getAttribute("user_id") != null;
%>

<!--
Reservation Summary Page - Alpha Team
Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh

Purpose:
This page presents the details of a reservation after confirmation or lookup. 
It shows confirmation number, room details, dates, and price, and provides users with options to:
- Cancel their reservation (sends request to servlet)
- Edit reservation if logged in
- Proceed to final submission if needed
-->

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reservation Summary</title>
  <link rel="stylesheet" href="reservationsummary.css">
</head>
<body>

  <!-- Site navigation bar for consistent UI -->
  <jsp:include page="Navbar.jsp" flush="true" />

  <main>
    <div class="card">
      <h2>Booking Confirmation</h2>
      <h3>Booking Details</h3>

      <!-- Confirmation Number -->
      <p style="text-align: center; font-size: 16px;">
        Confirmation Number: <strong><%= request.getAttribute("confirmationNumber") %></strong>
      </p>

      <!-- Summary Block with reservation metadata -->
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
          <strong><%= request.getAttribute("roomCount") %></strong>
        </div>
        <div class="summary-item">
          <p>Total Cost:</p>
          <strong>$<%= request.getAttribute("totalCost") %></strong>
        </div>
      </div>

      <!-- List of room types and counts -->
      <div class="room-details">
        Room Details:
        <strong><%= request.getAttribute("roomDetails") %></strong>
      </div>

      <!-- Optional special requests -->
      <% if (request.getAttribute("specialRequests") != null) { %>
        <div class="room-details">
          Special Requests:
          <strong><%= request.getAttribute("specialRequests") %></strong>
        </div>
      <% } %>

      <!-- Cancel Reservation Form -->
      <form method="post" action="ReservationServlet">
        <input type="hidden" name="action" value="cancelReservation">
        <input type="hidden" name="reservationId" value="<%= request.getAttribute("reservationId") %>">
        <div class="buttons">
          <button id="cancelbtn" type="submit">Cancel</button>
        </div>
      </form>

      <!-- Optional Submit Form (if user flow requires it) -->
      <form method="post" action="resConfirmation.jsp">
        <div class="buttons">
          <button id="submitbtn" type="submit">Submit</button>
        </div>
      </form>

      <!-- Edit Form for Logged-in Users -->
      <% if (isLoggedIn) { %>
        <form method="post" action="ReservationServlet">
          <input type="hidden" name="action" value="editReservation">
          <input type="hidden" name="checkInDate" value="<%= request.getAttribute("checkInDate") %>">
          <input type="hidden" name="checkOutDate" value="<%= request.getAttribute("checkOutDate") %>">
          <input type="hidden" name="numGuests" value="<%= request.getAttribute("numOfGuests") %>">
          <input type="hidden" name="roomDetails" value="<%= request.getAttribute("roomDetails") %>">
          <input type="hidden" name="roomCount" value="<%= request.getAttribute("roomCount") %>">
          <input type="hidden" name="confirmationNumber" value="<%= request.getAttribute("confirmationNumber") %>">
          <input type="hidden" name="reservationId" value="<%= request.getAttribute("reservationId") %>">
          <div class="buttons" style="margin-top: 10px;">
            <button id="editbtn" type="submit">Edit</button>
          </div>
        </form>
      <% } else { %>
        <!-- If not logged in, prompt login to edit -->
        <div class="login-reminder">
          Login to edit your reservation. <a href="login.jsp">Go to Login</a>
        </div>
      <% } %>
    </div>
  </main>

  <!-- Include site footer -->
  <jsp:include page="Foot.jsp" flush="true" />

</body>
</html>
