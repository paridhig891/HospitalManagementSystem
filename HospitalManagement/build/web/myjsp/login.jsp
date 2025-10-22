<%-- 
    Document   : login
    Created on : 18-Oct-2025, 11:10:14 pm
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Hospital Admin Login</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="../mycss/signup.css"/>
</head>
<body>

<div class="container">
    <div class="left-panel">
        <img src="https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?auto=format&fit=crop&w=800&q=80" alt="Medical Professional"/>
        <div class="overlay-text">
            <h1>Welcome Back</h1>
            <p>Login to manage your hospital system efficiently.</p>
        </div>
    </div>

    <div class="right-panel">
        <div class="form-container">
            <h2>Admin Login</h2>
            <form action="#" method="post">
                <input type="text" name="username" placeholder="Username" required />
                <input type="password" name="password" placeholder="Password" required />
                <button type="button" onclick="window.location.href='dashboard.jsp'">Login</button>
            </form>
            <p>Don't have an account? <a href="signup.jsp">Sign Up here</a></p>
        </div>
    </div>
</div>

</body>
</html>
