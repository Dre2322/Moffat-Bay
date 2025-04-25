<!--
 * Reservation Summary Page - Alpha Team
 * Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh
 *
 * Purpose:
 * This page displays a user's booking confirmation after they complete or look up a reservation.
 * It shows key reservation details such as dates, guest count, room types, total cost, and provides
 * options to cancel, submit, or edit the reservation depending on login status.
-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Redirect to homepage if summary data was not properly set
    if (request.getAttribute("confirmationNumber") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Safely check session to determine if user is logged in
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
    
  <jsp:include page="Navbar.jsp" flush="true" />

  <main>
    <div class="card">
      <h2>Booking Confirmation</h2>
      <h3>Booking Details</h3>

      <p style="text-align: center; font-size: 16px;">
        Confirmation Number: <strong><%= request.getAttribute("confirmationNumber") %></strong>
      </p>

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

      <div class="room-details">
        Room Details: 
        <strong><%= request.getAttribute("roomDetails") != null ? request.getAttribute("roomDetails") : "No room details available" %></strong>
      </div>

      <% if (request.getAttribute("specialRequests") != null) { %>
        <div class="room-details">
          Special Requests: <strong><%= request.getAttribute("specialRequests") %></strong>
        </div>
      <% } %>

      <form method="post" action="resConfirmation.jsp">
        <div class="buttons">
          <button id="cancelbtn" type="button" onclick="location.href='index.jsp'">Cancel</button>
          <button id="submitbtn" type="submit">Submit</button>
        </div>
      </form>

      <% if (isLoggedIn) { %>
        <form method="post" action="ReservationServlet">
          <input type="hidden" name="action" value="editReservation">
          <input type="hidden" name="checkInDate" value="<%= request.getAttribute("checkInDate") %>" />
          <input type="hidden" name="checkOutDate" value="<%= request.getAttribute("checkOutDate") %>" />
          <input type="hidden" name="numGuests" value="<%= request.getAttribute("numOfGuests") %>" />
          <input type="hidden" name="roomDetails" value="<%= request.getAttribute("roomDetails") %>" />
          <input type="hidden" name="roomCount" value="<%= request.getAttribute("roomCount") %>" />
          <input type="hidden" name="confirmationNumber" value="<%= request.getAttribute("confirmationNumber") %>" />
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

  <jsp:include page="Foot.jsp" flush="true" />

</body>
</html>
