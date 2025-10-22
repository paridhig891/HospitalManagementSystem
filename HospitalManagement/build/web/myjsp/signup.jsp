<%-- 
    Document   : signup
    Created on : 18-Oct-2025, 3:27:23 pm
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Admin Sign Up</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../mycss/signup.css">
</head>
<body>

<div class="container">
    <div class="left-panel">
        <img src="https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?auto=format&fit=crop&w=800&q=80" alt="Medical Professional">
        <div class="overlay-text">
            <h1>Welcome Admin</h1>
            <p>Empower better healthcare through smart hospital management.</p>
        </div>
    </div>

    <div class="right-panel">
        <div class="form-container">
            <h2>Admin Sign Up</h2>
            <form action="#" method="post" onsubmit="return validateForm()">
                <input type="text" name="fullname" id="fullname" placeholder="Full Name" required>
                <input type="email" name="email" id="email" placeholder="Email Address" required>
                <input type="text" name="username" id="username" placeholder="Username" required>
                
                <div class="password-field">
                    <input type="password" name="password" id="password" placeholder="Password" required>
                    <div class="password-strength" id="passwordStrength"></div>
                    <div class="password-requirements">
                        <small id="requirements">
                            Password must contain: 8+ characters, uppercase, lowercase, number, special character
                        </small>
                    </div>
                </div>
                
                <input type="password" name="confirm_password" id="confirmPassword" placeholder="Confirm Password" required>
                <div class="error-message" id="errorMessage"></div>
                
                <button onclick="window.location.href='login.jsp'">Create Account</button>

            </form>
            <p>Already have an account? <a href="login.jsp">Login here</a></p>
        </div>
    </div>
</div>

<script src="../myjs/pass.js"></script>
</body>
</html>
