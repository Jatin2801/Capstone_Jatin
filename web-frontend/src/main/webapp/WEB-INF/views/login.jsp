<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Login</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>

<body>

<div class="login-wrapper fade">

    <h1>Login</h1>

    <!-- ADMIN LOGIN -->
    <h2 class="login-title">Admin Login</h2>

    <form action="${pageContext.request.contextPath}/admin/login" method="post" class="login-form">
        <input type="text"     name="username" placeholder="Admin Username" required>
        <input type="password" name="password" placeholder="Password" required>

        <button class="login-btn">Login as Admin</button>
    </form>

    <hr class="divider">

    <!-- USER LOGIN -->
    <h2 class="login-title">User Login</h2>

    <form action="${pageContext.request.contextPath}/user/login" method="post" class="login-form">
        <input type="text"     name="username" placeholder="User Username" required>
        <input type="password" name="password" placeholder="Password" required>

        <button class="login-btn">Login as User</button>
    </form>

    <a href="/register">Create an Account</a>

</div>

</body>
</html>
