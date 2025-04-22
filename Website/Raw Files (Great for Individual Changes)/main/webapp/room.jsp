<!-- Rooms Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh --><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Select Your Rooms</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Open Sans', sans-serif;
      background-color: #f5f7fa;
      margin: 0;
      padding: 60px 0;
      display: flex;
      justify-content: center;
    }

    .container {
      background-color: #fff;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
      width: 90%;
      max-width: 750px;
    }

    h2 {
      text-align: center;
      margin-bottom: 30px;
      color: #2c3e50;
    }

    .form-group {
      margin-bottom: 25px;
    }

    label {
      font-weight: bold;
      display: block;
      margin-bottom: 6px;
      color: #333;
    }

    input[type="number"],
    input[type="text"] {
      width: 100%;
      padding: 12px;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 8px;
      background-color: #f8f8f8;
    }

    .room-entry {
      background-color: #fdfdfd;
      border: 1px solid #e4e4e4;
      padding: 20px;
      border-radius: 10px;
      margin-bottom: 20px;
    }

    .room-checkbox-label {
      display: flex;
      align-items: center;
      gap: 10px;
      font-weight: 600;
      margin-bottom: 12px;
    }

    .room-sub {
      display: flex;
      flex-direction: column;
    }

    .room-sub label {
      margin-bottom: 5px;
    }

    .submit-btn {
      width: 100%;
      background-color: #3ec6f0;
      color: white;
      padding: 14px;
      font-size: 18px;
      border: none;
      border-radius: 10px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .submit-btn:hover {
      background-color: #33b1d6;
    }

    .error {
      color: red;
      font-size: 14px;
      text-align: center;
      margin-top: 12px;
    }
  </style>

  <script>
    function toggleRoomCount(checkbox, id) {
      document.getElementById(id).disabled = !checkbox.checked;
    }

    window.onload = function () {
      <% 
        String[] selectedRoomTypeIds = (String[]) session.getAttribute("edit_roomTypeIds");
        Map<String, String> selectedRoomCounts = (Map<String, String>) session.getAttribute("edit_roomCounts");
        if (selectedRoomTypeIds != null) {
          for (String roomId : selectedRoomTypeIds) {
      %>
        document.getElementById("roomTypeCheckbox_<%= roomId %>").checked = true;
        document.getElementById("roomCount_<%= roomId %>").disabled = false;
        document.getElementById("roomCount_<%= roomId %>").value = "<%= selectedRoomCounts.get(roomId) %>";
      <% 
          }
        }
      %>
    }
  </script>
</head>
<body>
<div class="container">
  <h2>Select Your Rooms</h2>

  <%
    String startDate = (String) request.getAttribute("startDate");
    String endDate = (String) request.getAttribute("endDate");
    String numGuests = (String) session.getAttribute("edit_numGuests");
    if (startDate == null) startDate = (String) session.getAttribute("pendingReservation_startDate");
    if (endDate == null) endDate = (String) session.getAttribute("pendingReservation_endDate");
    if (numGuests == null) numGuests = "";
  %>

  <form method="post" action="ReservationServlet">
    <input type="hidden" name="action" value="confirmReservation">
    <input type="hidden" name="startDate" value="<%= startDate %>">
    <input type="hidden" name="endDate" value="<%= endDate %>">

    <div class="form-group">
      <label for="numGuests">Number of Guests:</label>
      <input type="number" name="numGuests" id="numGuests" required min="1" value="<%= numGuests %>" />
    </div>

    <%
      List<HashMap<String, String>> rooms = null;
      Object roomsObj = request.getAttribute("availableRooms");
      if (roomsObj instanceof List<?>) {
          List<?> tempList = (List<?>) roomsObj;
          if (!tempList.isEmpty() && tempList.get(0) instanceof HashMap) {
              rooms = (List<HashMap<String, String>>) roomsObj;
          }
      }

      if (rooms != null && !rooms.isEmpty()) {
          for (HashMap<String, String> room : rooms) {
              String id = room.get("room_type_id");
              String isChecked = (selectedRoomTypeIds != null && Arrays.asList(selectedRoomTypeIds).contains(id)) ? "checked" : "";
              String countVal = (selectedRoomCounts != null && selectedRoomCounts.containsKey(id)) ? selectedRoomCounts.get(id) : "0";
              boolean enabled = "checked".equals(isChecked);
    %>

    <div class="room-entry">
      <label class="room-checkbox-label">
        <input type="checkbox" name="roomTypeId" value="<%= id %>" id="roomTypeCheckbox_<%= id %>" onclick="toggleRoomCount(this, 'roomCount_<%= id %>')" <%= isChecked %> />
        <strong><%= room.get("room_name") %></strong> - $<%= room.get("price_per_night") %> per night
      </label>
      <div class="room-sub">
        <label for="roomCount_<%= id %>">Number of Rooms:</label>
        <input type="number" id="roomCount_<%= id %>" name="roomCount_<%= id %>" value="<%= countVal %>" min="0" <%= enabled ? "" : "disabled" %> />
      </div>
    </div>

    <% 
        }
      } else {
    %>
      <p style="text-align: center;">No rooms available for the selected dates.</p>
    <% } %>

    <button type="submit" class="submit-btn">Confirm Reservation</button>
    <p class="error"><%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %></p>
  </form>
</div>
</body>
</html>