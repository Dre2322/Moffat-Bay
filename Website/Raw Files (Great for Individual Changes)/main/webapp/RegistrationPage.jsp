<!-- Registration Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="description" content="Registration Page">
    <meta name="keywords" content="HTML, JSP, CSS">
    <meta name="author" content="Jeffrey Reid">

    <link rel="stylesheet" href="RegistrationPage.css">
	
	<title>Registration Page</title>
	
</head>
<script>
	<!-- email regex = "^[\\w.-]+@[\\w.-]+\\.\\w{2,}$" -->
	<!-- phone regex = "^(\\d{3}[- .]?){1}\\d{4}$" -->
	<!-- pass regex = "^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\w).{8,}$" -->
	<!-- This Checks to see if both Passwords match before submission -->
	function check() {
		var input = document.getElementById('confirmpass');
		if (input.value != document.getElementById('pass').value) {
			input.setCustomValidity('Passwords Must Match to Proceed!');
		}
		else {
			//If Passwords Match, reset Error message
			input.setCustomValidity('');
		}
	}
	
	<!-- This Validates that the Phone Number is 7 digits. Hyphen, Dot, and Space is allowed -->
	function validatePhoneNumber() {
		var phoneregex = "^(\\d{3}[- .]?){1}\\d{4}$";
		var input = document.getElementById('phone');
		if (input.value.match(phoneregex) == null) {
			input.setCustomValidity('Phone Number must be Seven Digits!');
		}
		else {
			//If Phone Number is Valid, continue
			input.setCustomValidity('');
		}
	}
</script>
<body>

	<!-- This imports the NavBar into the page -->
	<jsp:include page="Navbar.jsp" flush="true"></jsp:include>

	<div id="container">
	
        <h1> Create a New Account </h1>
        
        <div class="requiredfield">
            <h3> <span>*</span>indicates a required field </h3>
        </div>	
        
        <div class="passrequirements">	
            <h3> <span>*</span>Password must contain 1 Uppercase, 1 Lowercase, and 1 Special Character. It must also include 1 Number and be a minimum of 8 characters.</h3>	
        </div>

        
		<!-- Form to Add Registration to Server should requirements be met -->
		<!-- Required Entries are First and Last Name, Email, Phone, Password, and Confirm Password -->
		<!-- Password must have 1 Upper and Lower-case letter, 1 Number, 1 Special Character, and be a min of 8 characters -->
		<!-- Password and Confirm Password must match -->
		<!-- Maybe add place-holders? -->
        <form autocomplete="off" action="Registration" method="Post">
        
        	<!-- This is to ensure the auto-complete actually stays off -->        
        	<input type="hidden" tabindex="-1" style="left: -9999px;" type="text">
        	<input type="hidden" tabindex="-1" style="left: -9999px;" type="password">

            <div class="entryfields">

                <div class="entryleft">
                    <label class="firstname" for="firstname"><span>*</span> First Name:
                        <input type="text" id="firstname" name="firstname" required>
                    </label>
                    <label class="lastname" for="lastname"><span>*</span> Last Name:
                        <input type="text" id="lastname" name="lastname" required>
                    </label>
                    <label class="email" for="email"><span>*</span> Email Address:
                        <input type="email" id="email" name="email" required
                        pattern = "^[\\w.-]+@[\\w.-]+\\.\\w{2,}$">
                    </label>
                    <label class="phone" for="phone"><span>*</span> Phone:
                        <input type="tel" id="phone" name="phone" required oninput="validatePhoneNumber()">
                    </label>

                </div>

                <div class="entryright">
                    <label class="address" for="address">Address:
                        <input type="text" id="address" name="address">
                    </label>
                    <label class="city" for="city">City:
                        <input type="text" id="city" name="city">
                    </label>
                    <label class="state" for="state">State:
                        <input type="text" id="state" name="state">
                    </label>
                    <label class="zip" for="zip">Zipcode:
                        <input type="text" id="zip" name="zip">
                    </label>

                </div>

                <div class="entryleft2">
                    <label class="pass" for="pass"><span>*</span> Enter Password:
                        <input type="password" id="pass" name="pass" required 
                        pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\w).{8,}$">
                    </label>
                </div>

                <div class="entryright2">
                    <label class="confirmpass" for="confirmpass"><span>*</span> Confirm Password:
                        <input type="password" id="confirmpass" name="confirmpass" required oninput="check()">
                    </label>
                </div>

            </div>

            <input type="hidden" name="this" value="create">
            <input class="create" type="submit" id="create" value="Create">

        </form>
        
		<p class="error">
			<%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
		</p>
	
	</div>
	
	<!-- This imports the Footer into the page below everything -->
	<jsp:include page="Foot.jsp" flush="true"></jsp:include>

</body>
</html>