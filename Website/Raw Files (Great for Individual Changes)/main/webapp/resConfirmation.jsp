<!-- Reservation Confirmation Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Reservation Confirmation Page">
    <meta name="keywords" content="HTML, JSP, CSS">
    <meta name="author" content="Edgar Arroyo">
    
    <style>
    
	   #container {
		   background-color: #f4f8fb;
		   border-radius: 5px;
		   margin: 80px auto;
		   padding: 20px;
		   width: 80%;
		   max-width: 1000px;
		   box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		   color: #333;
		}
		
		html, body {
			height: 100%;
    		margin: 0;
    		padding: 0;
    		display: flex;
    		flex-direction: column;
		}
		
		main {
    		flex: 1;
		}
		
		h2, p {
			text-align: center;
		}
		
		button {
			display: block;
            padding: 12px 24px;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: auto;
        }
        
		#submitbtn {
            background-color: #3498db;
            color: white;
        }
    
    </style>
    
    <title>Confirmed!</title>
</head>
<body>
	<jsp:include page="Navbar.jsp" flush="true"></jsp:include>
	
	<main>
		<div id="container">
		
			<h2> Your reservation has been confirmed! </h2><br>
			
			<p> We're overjoyed you've chosen to stay with us. Feel free to browse some of the 
				<a href="attractions.jsp">activities</a> available to you as our guest.
				We'll see you soon!
			</p><br><br>
			
			<button id="submitbtn" type="button" onclick="location.href='index.jsp'">Home</button>
		</div>
	</main>
	
	<jsp:include page="Foot.jsp" flush="true"></jsp:include>

</body>
</html>