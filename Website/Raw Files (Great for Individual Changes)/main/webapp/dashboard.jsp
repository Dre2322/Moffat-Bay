<!-- User Welcome Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->

<!-- Purpose:
This page greets the logged-in user by displaying their first name, which is retrieved from the session.
If the user is not logged in, they are redirected to the login page. The page includes a welcome message and
imports shared elements such as the navigation bar and footer. This provides a personalized user experience for
authenticated users. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession usersession = request.getSession(false);
    if (usersession == null || usersession.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return; // Ensure no further processing occurs after redirect
    }
    String firstName = (String) usersession.getAttribute("first_name");
%>
<html>
<head>
    <meta name="author" content="Jordany Gonzalez, Jeffrey Reid">
    <title>Welcome</title>
</head>
<style>
    .welcome {
        max-width: 400px;
        margin: 15% auto;
        background-color: azure;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        text-align: center;
    }

    .logout {
        margin-top: 10px;
    }
</style>
<body>

    <!-- This imports the NavBar into the page -->
    <jsp:include page="Navbar.jsp" flush="true"/>

    <div class="welcome">
        <h2>Welcome, <%= firstName %>!</h2>
    </div>

    <!-- This imports the Footer into the page below everything -->
    <jsp:include page="Foot.jsp" flush="true"/>

</body>
</html>
