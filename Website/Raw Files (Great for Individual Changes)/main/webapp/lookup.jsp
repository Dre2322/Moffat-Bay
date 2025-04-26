<!-- Lookup Reservation Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->

<!-- Purpose:
    This page allows users to look up their reservation by providing either a confirmation number or an email address.
    It submits the data to LookupReservationServlet, which handles the validation and lookup logic using a JOIN
    between reservations and users. If an error is encountered (e.g., no match or email mismatch), it is displayed here. -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Look Up Reservation</title>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Open Sans', sans-serif;
            background-color: #f9f9f9;
            color: #2c3e50;
            /*display: block;
            justify-content: center;
            align-items: center;
            height: 100vh;*/
        }

        .container {
            background: white;
            padding: 100px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 100%;
            max-width: 1000px;
            /*overflow: hidden;*/
            /*Moved here for testing*/
            /*display: block;
            justify-content: center;
            align-items: center;
            height: 50vh;*/
            /*Added these*/
            margin: 10% auto;
            /*box-sizing: none;*/
        }

        h2 {
            margin-bottom: 10px;
        }

        p.note {
            font-size: 14px;
            color: #666;
            margin-bottom: 25px;
        }

        input[type="text"],
        input[type="email"] {
            width: 90%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            background-color: #0077cc;
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #005fa3;
        }

        .error {
            color: red;
            margin-top: 10px;
        }
        
        #lookupDetails table, 
		#lookupDetails th, 
		#lookupDetails td {
    		border: none; 
		}
		
		#lookupDetails th, td {
			padding: 10px 20px;
			text-align:center;
		}
		
		#lookupDetails table {
			width: 100%;
			border-collapse: separate;
			border-spacing: 0 10px;
		}
		
		#lookupDetails h2 {
		    text-align: left;
		    font-size: 20px;
		    color: #333;
		}
		
		#lookupDetails {
			margin-top: 40px;
			margin-left: -30px;
		}
        
    </style>
</head>
<body>


<!-- This imports the NavBar into the page -->
<jsp:include page="Navbar.jsp" flush="true"></jsp:include>

	<div class="container">
	    <h2>Look Up Your Reservation</h2>
	    <p class="note">Enter your confirmation number or email — only one is required.</p>
	
	    <form action="LookupReservationServlet" method="post">
	        <input type="text" name="confirmationNumber" placeholder="Confirmation Number"><br>
	        <input type="email" name="email" placeholder="Email"><br>
	        <input type="submit" value="Look Up Reservation">
	    </form>
	
	    <% 
	        String error = (String) request.getAttribute("error");
	        if (error != null) { 
	    %>
	        <div class="error"><%= error %></div>
	    <% 
	        } 
	    %>
	    
	    <div id="lookupDetails" >	
		    <%
		    	String confirmationNumber = (String) request.getAttribute("confirmationNumber");
		    	Integer numOfGuests = (Integer) request.getAttribute("numOfGuests");
		    	String checkInDate = (String) request.getAttribute("checkInDate");
		    	String checkOutDate = (String) request.getAttribute("checkOutDate");
		    	Double totalCost = (Double) request.getAttribute("totalCost");
		    	String roomName = (String) request.getAttribute("roomName");
		    	
		    	//if no attributes have been received from the servlet do not display this
		    	if (confirmationNumber != null) {
		    %>

		    
		    <h2> Your Stays: </h2>
		    
		    <div id="details">
			    <table>
			    	<tr>
			    		<th>Confirmation Number</th>
			    		<th>Room</th>
			    		<th>Guests</th>
			    		<th>Check In</th>
			    		<th>Check Out</th>
			    		<th> Total </th>
			    	</tr>
			    	<tr>
			    		<td><%= confirmationNumber %></td>
			    		<td><%= roomName %></td>
			    		<td><%= numOfGuests %></td>
			    		<td><%= checkInDate %></td>
			    		<td><%= checkOutDate %></td>
			    		<td><%= totalCost %></td>
			    	</tr>
			    </table>
		    </div>
		    <% } %> 	    
	    </div>
	    
	</div>

<!-- This imports the Footer into the Page below everything -->
<jsp:include page="Foot.jsp" flush="true"></jsp:include>

</body>
</html>
