<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.mehedi.service.impl.UserServiceImpl" %>
<%@ page import="com.mehedi.service.UserService" %>
<%@ page import="com.mehedi.beans.UserBean" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.ServletOutputStream" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Update Profile Action</title>
    <style>
        /* Basic styling for the circular loading animation */
        .loader {
            border: 8px solid #f3f3f3; /* Light grey */
            border-top: 8px solid #3498db; /* Blue */
            border-radius: 50%;
            width: 60px;
            height: 60px;
            animation: spin 1.5s linear infinite;
            display: none; /* Initially hidden */
            margin: 20px auto; /* Center the loader */
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
<%
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");

    // Check if the user is logged in
    if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
        return; // Stop further processing
    }

    UserService dao = new UserServiceImpl();

    // Retrieve user input from the request
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String pincode = request.getParameter("pincode");

    // Create a UserBean object
    UserBean user = new UserBean(name, Long.parseLong(phone), email, address, Integer.parseInt(pincode), null);
    
    // Update user details in the database
    String updateStatus = dao.updateUserDetails(user); // Assuming this method takes UserBean

    // Check the update status and display appropriate message
    if (updateStatus.equals("User updated successfully!")) {
%>
        <div class="loader"></div> <!-- Circular loading animation -->
        <h2>Profile updated successfully!</h2>
        <script>
            // Show the loader
            document.querySelector('.loader').style.display = 'block';

            // Redirect after a delay
            setTimeout(function() {
                window.location.href = 'userProfile.jsp';
            }, 2000); // Redirect after 2 seconds
        </script>
<%
    } else {
%>
        <h2><%= updateStatus %></h2> <!-- Display the status message -->
        <script>
            // Redirect back to the profile page after a few seconds
            setTimeout(function() {
                window.location.href = 'userProfile.jsp';
            }, 2000); // Redirect after 2 seconds
        </script>
<%
    }
%>
</body>
</html>
