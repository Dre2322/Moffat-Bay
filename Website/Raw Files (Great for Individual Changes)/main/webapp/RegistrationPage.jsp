<!-- Registration Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->

<!-- Purpose:
This page provides the registration functionality for users to create a new account on Moffat Bay Lodge's website.
It includes fields for the user's first name, last name, email, phone, address, city, state, zipcode, and password.
The form also validates the password criteria (uppercase, lowercase, special character, number, and minimum length),
ensures the confirmation password matches, and validates the phone number format. Upon successful registration,
the user's data will be processed and saved in the backend system. -->
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

<!-- JavaScript Section for client-side form validation -->
<script>
    // Checks if password and confirm password match
    function check() {
        var input = document.getElementById('confirmpass');
        if (input.value !== document.getElementById('pass').value) {
            input.setCustomValidity('Passwords Must Match to Proceed!');
        } else {
            input.setCustomValidity('');
        }
    }

    // Validates phone number input (10 digits with optional -, ., or space)
    function validatePhoneNumber() {
        var phoneregex = /^\d{3}[-.\s]?\d{3}[-.\s]?\d{4}$/;
        var input = document.getElementById('phone');
        if (!input.value.match(phoneregex)) {
            input.setCustomValidity('Phone Number must be 10 digits!');
        } else {
            input.setCustomValidity('');
        }
    }
</script>

<body>

    <!-- Include site-wide navigation -->
    <jsp:include page="Navbar.jsp" flush="true"></jsp:include>

    <div id="container">
        <h1>Create a New Account</h1>

        <div class="requiredfield">
            <h3><span>*</span>indicates a required field</h3>
        </div>

        <div class="passrequirements">
            <h3><span>*</span>Password must contain 1 Uppercase, 1 Lowercase, 1 Special Character, 1 Number, and be at least 8 characters long.</h3>
        </div>

        <!-- User registration form -->
        <form autocomplete="off" action="Registration" method="Post">
            
            <!-- Prevents auto-fill in some browsers -->
            <input type="hidden" tabindex="-1" style="left: -9999px;" type="text">
            <input type="hidden" tabindex="-1" style="left: -9999px;" type="password">

            <div class="entryfields">

                <!-- Left-side input fields -->
                <div class="entryleft">

                    <!-- First Name -->
                    <label class="firstname" for="firstname"><span>*</span> First Name:
                        <input type="text" id="firstname" name="firstname" required
                            placeholder="John" title="Enter your first name">
                    </label>

                    <!-- Last Name -->
                    <label class="lastname" for="lastname"><span>*</span> Last Name:
                        <input type="text" id="lastname" name="lastname" required
                            placeholder="Doe" title="Enter your last name">
                    </label>

                    <!-- Email -->
                    <label class="email" for="email"><span>*</span> Email Address:
                        <input type="email" id="email" name="email" required
                            pattern="^[\\w.-]+@[\\w.-]+\\.\\w{2,}$"
                            placeholder="user@example.com"
                            title="Enter a valid email (e.g. user@example.com)">
                    </label>

                    <!-- Phone -->
                    <label class="phone" for="phone"><span>*</span> Phone:
                        <input type="tel" id="phone" name="phone" required
                            pattern="[0-9]{3}[-.\s]?[0-9]{3}[-.\s]?[0-9]{4}"
                            placeholder="123-456-7890"
                            title="Enter a 10-digit phone number (e.g. 123-456-7890)"
                            oninput="validatePhoneNumber()">
                    </label>

                </div>

                <!-- Right-side input fields -->
                <div class="entryright">

                    <!-- Address -->
                    <label class="address" for="address">Address:
                        <input type="text" id="address" name="address"
                            placeholder="123 Main St"
                            title="Enter your street address">
                    </label>

                    <!-- City -->
                    <label class="city" for="city">City:
                        <input type="text" id="city" name="city"
                            placeholder="Seattle"
                            title="Enter your city">
                    </label>

                    <!-- State -->
                    <label class="state" for="state">State:
                        <input type="text" id="state" name="state"
                            placeholder="WA"
                            title="Enter your state abbreviation (e.g. WA)">
                    </label>

                    <!-- Zip Code -->
                    <label class="zip" for="zip">Zipcode:
                        <input type="text" id="zip" name="zip"
                            placeholder="98101"
                            title="Enter your ZIP code">
                    </label>

                </div>

                <!-- Left-bottom: Password -->
                <div class="entryleft2">
                    <label class="pass" for="pass"><span>*</span> Enter Password:
                        <input type="password" id="pass" name="pass" required
                            pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,}$"
                            placeholder="Create Password"
                            title="Minimum 8 characters. Must include uppercase, lowercase, number, and special character.">
                    </label>
                </div>

                <!-- Right-bottom: Confirm Password -->
                <div class="entryright2">
                    <label class="confirmpass" for="confirmpass"><span>*</span> Confirm Password:
                        <input type="password" id="confirmpass" name="confirmpass" required
                            placeholder="Confirm Password"
                            title="Must match the password above"
                            oninput="check()">
                    </label>
                </div>

            </div>

            <!-- Form submission -->
            <input type="hidden" name="this" value="create">
            <input class="create" type="submit" id="create" value="Create">

        </form>

        <!-- Server-side error message (if present) -->
        <p class="error">
            <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
        </p>

    </div>

    <!-- Include site-wide footer -->
    <jsp:include page="Foot.jsp" flush="true"></jsp:include>

</body>
</html>
