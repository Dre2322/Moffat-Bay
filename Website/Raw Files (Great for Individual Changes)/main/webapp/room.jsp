<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<!-- 
  Room Page - Alpha Team
  Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh

  Purpose:
  This page allows users to select rooms for their reservation at Moffat Bay Lodge.
  Users enter the number of guests and select how many rooms they need for each available room type using a dropdown menu.
  If a user selects "0" rooms, that room type will not be included in the final reservation.
  This updated version simplifies the interface by removing checkboxes and directly allowing room selection by quantity.
  It is styled for modern, clean, and mobile-responsive layout.
-->

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Select Your Rooms</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="room.css">
</head>
<body>
<!-- Include navigation bar -->
<jsp:include page="Navbar.jsp" flush="true" />
<div class="container">
  <h2>Select Your Rooms</h2>

  <%
    // Retrieve reservation dates and guest count from request or session
    String startDate = (String) request.getAttribute("startDate");
    String endDate = (String) request.getAttribute("endDate");
    String numGuests = (String) request.getAttribute("numGuests");
    if (startDate == null) startDate = (String) session.getAttribute("pendingReservation_startDate");
    if (endDate == null) endDate = (String) session.getAttribute("pendingReservation_endDate");
    if (numGuests == null) numGuests = (String) session.getAttribute("pendingReservation_numGuests");
    if (numGuests == null) numGuests = "";

    // Preload any room quantities if this is an edit
    Map<String, String> selectedRoomCounts = (Map<String, String>) session.getAttribute("edit_roomCounts");
  %>

  <!-- Main reservation form -->
  <form method="post" action="ReservationServlet">
    <!-- Hidden fields to pass dates and action -->
    <input type="hidden" name="action" value="confirmReservation">
    <input type="hidden" name="startDate" value="<%= startDate %>">
    <input type="hidden" name="endDate" value="<%= endDate %>">

    <!-- Input for number of guests -->
    <div class="form-group">
      <label for="numGuests">Number of Guests:</label>
      <input type="number" name="numGuests" id="numGuests" required min="1" value="<%= numGuests %>" />
    </div>

    <%
      // Load available room types from controller
      List<HashMap<String, String>> rooms = null;
      Object roomsObj = request.getAttribute("availableRooms");
      if (roomsObj instanceof List<?>) {
          List<?> tempList = (List<?>) roomsObj;
          if (!tempList.isEmpty() && tempList.get(0) instanceof HashMap) {
              rooms = (List<HashMap<String, String>>) roomsObj;
          }
      }

      // Display room options with dropdowns to choose quantity (0–5)
      if (rooms != null && !rooms.isEmpty()) {
          for (HashMap<String, String> room : rooms) {
              String id = room.get("room_type_id");
              String countVal = (selectedRoomCounts != null && selectedRoomCounts.containsKey(id)) ? selectedRoomCounts.get(id) : "0";
    %>

    <!-- Render each room type -->
    <div class="room-entry">
      <strong><%= room.get("room_name") %></strong>
      <div class="room-sub">
        <label for="roomCount_<%= id %>">Number of Rooms ($<%= room.get("price_per_night") %> per night):</label>
        <select id="roomCount_<%= id %>" name="roomCount_<%= id %>">
          <% for (int i = 0; i <= 5; i++) { %>
            <option value="<%= i %>" <%= countVal.equals(String.valueOf(i)) ? "selected" : "" %>><%= i %></option>
          <% } %>
        </select>
        <!-- Hidden input to preserve room type ID -->
        <input type="hidden" name="roomTypeId" value="<%= id %>">
      </div>
    </div>

    <% 
        }
      } else {
    %>
      <!-- Message if no rooms available -->
      <p style="text-align: center;">No rooms available for the selected dates.</p>
    <% } %>

    <!-- Submit button and error handling -->
    <button type="submit" class="submit-btn">Confirm Reservation</button>
    <p class="error"><%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %></p>
  </form>
</div>

<!-- This imports the Footer into the Page below everything -->
<jsp:include page="Foot.jsp" flush="true"></jsp:include>

</body>
</html>
