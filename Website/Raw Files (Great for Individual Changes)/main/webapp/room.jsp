<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<!-- 
  Room Selection Page - Alpha Team
  Team Members: Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh

  Purpose:
  This JSP page allows users to select rooms at Moffat Bay Lodge for a given reservation period.
  - It displays each available room type (retrieved from the servlet).
  - Guests can specify how many of each room type they want via dropdown menus (0–5).
  - The form submission routes to ReservationServlet for confirmation.
  - The servlet will calculate cost, store data, and redirect to ReservationSummary.jsp.

  This page is designed to support a cleaner, more intuitive UX using a dropdown-based interface.
-->

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Select Your Rooms</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <!-- Google Fonts and External CSS for Styling -->
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="room.css" />
</head>
<body>

  <!-- Include the site-wide navigation bar -->
  <jsp:include page="Navbar.jsp" flush="true" />

  <div class="container">
    <h2>Select Your Rooms</h2>

    <%
      // Retrieve session-persisted values or use request scope as fallback
      String startDate = (String) request.getAttribute("startDate");
      String endDate = (String) request.getAttribute("endDate");
      String numGuests = (String) request.getAttribute("numGuests");

      // Use session values if not present in request scope
      startDate = (startDate != null) ? startDate : (String) session.getAttribute("pendingReservation_startDate");
      endDate = (endDate != null) ? endDate : (String) session.getAttribute("pendingReservation_endDate");
      numGuests = (numGuests != null) ? numGuests : (String) session.getAttribute("pendingReservation_numGuests");
      numGuests = (numGuests != null) ? numGuests : ""; // Fallback to avoid null form value

      // Pull available room types loaded by servlet controller
      List<HashMap<String, String>> rooms = (List<HashMap<String, String>>) request.getAttribute("availableRooms");
    %>

    <!-- Reservation form submits to ReservationServlet for processing and confirmation -->
    <form method="post" action="ReservationServlet" onsubmit="return validateForm()">
      <!-- Hidden metadata to persist form state across requests -->
      <input type="hidden" name="action" value="confirmReservation" />
      <input type="hidden" name="startDate" value="<%= startDate %>" />
      <input type="hidden" name="endDate" value="<%= endDate %>" />

      <!-- Guest count field (numeric input) -->
      <div class="form-group">
        <label for="numGuests">Number of Guests:</label>
        <input type="number" name="numGuests" id="numGuests" required min="1" value="<%= numGuests %>" />
      </div>

      <%
        // Dynamically list all available room types with corresponding dropdowns
        if (rooms != null && !rooms.isEmpty()) {
          for (HashMap<String, String> room : rooms) {
            String id = room.get("room_type_id");
            String name = room.get("room_name");
            String price = room.get("price_per_night");
      %>

        <!-- Room Type Selection Card -->
        <div class="room-entry">
          <strong><%= name %></strong>
          <div class="room-sub">
            <label for="roomCount_<%= id %>">Number of Rooms ($<%= price %> per night):</label>
            <!-- Quantity dropdown menu (0–5 rooms) -->
            <select id="roomCount_<%= id %>" name="roomCount_<%= id %>" required>
              <option value="0">0</option>
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
            </select>

            <!-- Hidden input to associate this dropdown with room type ID -->
            <input type="hidden" name="roomTypeId" value="<%= id %>" />
          </div>
        </div>

      <% } } else { %>
        <!-- Fallback message when no rooms are available for the chosen dates -->
        <p style="text-align: center;">No rooms available for the selected dates.</p>
      <% } %>

      <!-- Display any server-generated error messages if validation fails -->
      <p class="error"><%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %></p>

      <!-- Submit button to finalize room selections -->
      <button type="submit" class="submit-btn">Continue to Summary</button>
    </form>
  </div>

  <!-- Footer displayed site-wide -->
  <jsp:include page="Foot.jsp" flush="true" />

  <!-- Basic client-side validation for form submission -->
  <script>
    function validateForm() {
      let isValid = false;
      // Loop through room count selections to ensure at least one room type is selected
      const selects = document.querySelectorAll('select[name^="roomCount_"]');
      selects.forEach(select => {
        if (select.value > 0) {
          isValid = true;
        }
      });
      if (!isValid) {
        alert("Please select at least one room type.");
        return false; // Prevent form submission if no rooms are selected
      }
      return true;
    }
  </script>

</body>
</html>
