<!-- 
 * Reservation Confirmation Page - Alpha Team
 * Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh
 *
 * Purpose:
 * This page displays a message confirming that the user's reservation has been successfully submitted.
 * It includes a return button and a link to explore available guest attractions.
-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="Reservation Confirmation Page" />
    <meta name="keywords" content="HTML, JSP, CSS" />
    <meta name="author" content="Alpha Team" />
    <title>Reservation Confirmed</title>

    <style>
        /* Global and Layout Styles */
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            font-family: 'Open Sans', sans-serif;
            background-color: #e8f0f8;
        }

        main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        /* Confirmation Card */
        #container {
            background-color: #f4f8fb;
            border-radius: 8px;
            padding: 40px;
            max-width: 800px;
            width: 100%;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
            text-align: center;
            color: #2c3e50;
        }

        h2 {
            font-size: 28px;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            margin-bottom: 30px;
        }

        p a {
            color: #3498db;
            text-decoration: none;
        }

        p a:hover {
            text-decoration: underline;
        }

        /* Button Styling */
        #submitbtn {
            background-color: #3498db;
            color: white;
            padding: 12px 28px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }

        #submitbtn:hover {
            background-color: #2980b9;
        }
        
        /* ✅ Animated checkmark */
        .checkmark-container {
            display: flex;    
            justify-content: center;
            margin-bottom: 25px;
		}

		.checkmark-circle {
	        width: 80px;
    	    height: 80px;
    	    border-radius: 50%;
    	    background-color: #2ecc71;
    	    position: relative;
    	    animation: popIn 0.6s ease-out;
	    }

	    .checkmark-stem, .checkmark-kick {
    	    position: absolute;
    	    background-color: #fff;
    	    border-radius: 2px;
	    }

	    .checkmark-stem {
    	    width: 6px;
    	    height: 30px;
    	    top: 22px;
    	    left: 36px;
    	    transform: rotate(-45deg);
    	    animation: draw 0.3s ease-out 0.6s forwards;
    	 	opacity: 0;
	    }

	 	.checkmark-kick {
	 	    width: 6px;
    	 	height: 16px;
    	 	top: 40px;
    	 	left: 26px;
    	 	transform: rotate(45deg);
    	 	animation: draw 0.3s ease-out 0.9s forwards;
    	 	opacity: 0;
	 	}

	 	@keyframes popIn {
    	 	0% {
        	 	transform: scale(0.5);
        	 	opacity: 0;
    	 	}
    	 	100% {
        	 	transform: scale(1);
        	 	opacity: 1;
    	 	}
	 	}

	 	@keyframes draw {
    	 	to {
        	 	opacity: 1;
    	 	}
		 }
        
    </style>
</head>
<body>

    <jsp:include page="Navbar.jsp" flush="true" />

    <main>
        <div id="container">
            <div class="checkmark-container">
                <div class="checkmark-circle">
                    <div class="checkmark-stem"></div>
                    <div class="checkmark-kick"></div>
                </div>
            </div>

            <h2>Your reservation has been confirmed!</h2>
            <p>
                We're overjoyed you've chosen to stay with us. Feel free to browse some of the 
                <a href="attractions.jsp">activities</a> available to you as our guest. We'll see you soon!
            </p>

            <button id="submitbtn" onclick="location.href='index.jsp'">Home</button>
        </div>
    </main>

    <jsp:include page="Foot.jsp" flush="true" />

</body>
</html>
