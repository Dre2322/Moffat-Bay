<!-- Reservation Summary Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Reservation Summary</title>
  <style>
    body {
      font-family: 'Open Sans', sans-serif;
      background: url('https://images.unsplash.com/photo-1506744038136-46273834b3fb') no-repeat center center/cover;
      margin: 0;
      padding: 0;
    }

    main {
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 80px 20px;
    }

    .card {
      background-color: #f4f8fb;
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
      max-width: 900px;
      width: 100%;
    }

    h2 {
      text-align: center;
      font-size: 28px;
      margin-bottom: 10px;
      color: #2c3e50;
    }

    h3 {
      text-align: center;
      color: #3498db;
      margin-bottom: 30px;
    }

    .summary-row {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      margin-bottom: 20px;
    }

    .summary-item {
      flex: 1 1 22%;
      text-align: center;
      padding: 10px;
      border-right: 1px solid #e0e0e0;
    }

    .summary-item:last-child {
      border-right: none;
    }

    .summary-item p {
      margin: 5px 0;
      font-weight: 600;
      color: #2c3e50;
    }

    .summary-item strong {
      font-size: 18px;
      display: block;
      margin-top: 4px;
    }

    .room-details {
      text-align: center;
      margin-top: 20px;
      font-size: 16px;
    }

    .room-details strong {
      color: #2c3e50;
    }

    .buttons {
      display: flex;
      justify-content: center;
      gap: 20px;
      margin-top: 40px;
    }

    .buttons button {
      padding: 12px 28px;
      font-size: 16px;
      border-radius: 6px;
      border: none;
      cursor: pointer;
      transition: 0.3s;
    }

    #cancelbtn {
      background-color: #e74c3c;
      color: #fff;
    }

    #cancelbtn:hover {
      background-color: #c0392b;
    }

    #editbtn {
      background-color: #f39c12;
      color: white;
    }

    #editbtn:hover {
      background-color: #d68910;
    }

    #submitbtn {
      background-color: #3498db;
      color: #fff;
    }

    #submitbtn:hover {
      background-color: #2980b9;
    }

    @media (max-width: 768px) {
      .summary-row {
        flex-direction: column;
        align-items: center;
      }

      .summary-item {
        flex: 1 1 100%;
        border-right: none;
        border-bottom: 1px solid #e0e0e0;
        margin-bottom: 10px;
      }

      .summary-item:last-child {
        border-bottom: none;
      }
    }
  </style>
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
          <strong><%= request.getAttribute("roomCount") %></strong>
        </div>
        <div class="summary-item">
          <p>Total Cost:</p>
          <strong>$<%= request.getAttribute("totalCost") %></strong>
        </div>
      </div>

      <div class="room-details">
        Room Details: <strong><%= request.getAttribute("roomDetails") %></strong>
      </div>

      <form method="post" action="resConfirmation.jsp">
		<div class="buttons">
    		<button id="cancelbtn" type="button" onclick="location.href='index.jsp'">Cancel</button>
    		<button id="submitbtn" type="submit">Submit</button>
 		</div>
	  </form>

	  <!-- Separate form for Edit -->
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
    </div>
  </main>

  <jsp:include page="Foot.jsp" flush="true" />
</body>
</html>
