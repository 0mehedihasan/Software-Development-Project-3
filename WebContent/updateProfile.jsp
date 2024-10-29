<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.mehedi.service.impl.*,com.mehedi.service.*,com.mehedi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Profile</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/changes.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

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

        .result-message {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body style="background-color: #E6F9E6;">

<%
    // Checking user credentials
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");

    if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
    }

    UserService dao = new UserServiceImpl();
    UserBean user = dao.getUserDetails(userName, password);
    if (user == null) {
        user = new UserBean("Test User", 98765498765L, "test@gmail.com", "ABC colony, Patna, bihar", 87659, "lksdjf");
    }
%>

<jsp:include page="header.jsp" />

<div class="container bg-secondary">
    <h2 class="text-center">Update Profile</h2>
    <form id="updateProfileForm" class="form-horizontal">
        <div class="form-group">
            <label for="name" class="control-label col-sm-2">Full Name:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() %>" required>
            </div>
        </div>
        <div class="form-group">
            <label for="email" class="control-label col-sm-2">Email:</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>" required>
            </div>
        </div>
        <div class="form-group">
            <label for="phone" class="control-label col-sm-2">Phone:</label>
            <div class="col-sm-10">
                <input type="tel" class="form-control" id="phone" name="phone" value="<%= user.getMobile() %>" required>
            </div>
        </div>
        <div class="form-group">
            <label for="address" class="control-label col-sm-2">Address:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="address" name="address" value="<%= user.getAddress() %>" required>
            </div>
        </div>
        <div class="form-group">
            <label for="pincode" class="control-label col-sm-2">Pin Code:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="pincode" name="pincode" value="<%= user.getPinCode() %>" required>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="button" class="btn btn-success" id="updateProfileButton">Update Profile</button>
            </div>
        </div>
    </form>
    
    <div class="loader" id="loader"></div> <!-- Circular loading animation -->
    <div class="result-message" id="resultMessage"></div> <!-- For displaying result messages -->
</div>

<script>
    $(document).ready(function() {
        $("#updateProfileButton").click(function() {
            // Show the loader
            $("#loader").show();
            $("#resultMessage").text(''); // Clear previous messages
            
            // Get form data
            var formData = {
                name: $("#name").val(),
                email: $("#email").val(),
                phone: $("#phone").val(),
                address: $("#address").val(),
                pincode: $("#pincode").val()
            };

            // Make AJAX request to update user profile
            $.ajax({
                type: "POST",
                url: "updateProfileAction.jsp", // Replace with your server-side update script
                data: formData,
                success: function(response) {
                    // Hide the loader
                    $("#loader").hide();
                    // Display success or failure message
                    $("#resultMessage").html(response);
                },
                error: function() {
                    $("#loader").hide();
                    $("#resultMessage").html('<h4>Error updating profile. Please try again.</h4>');
                }
            });
        });
    });
</script>

</body>
</html>
