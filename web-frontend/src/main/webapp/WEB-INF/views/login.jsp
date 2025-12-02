<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>

<div class="container">
    <h2>Login</h2>

    <form action="/admin/login" method="post">
        <h3>Admin Login</h3>
        <input type="text" name="username" placeholder="Admin Username">
        <input type="password" name="password" placeholder="Password">
        <button type="submit">Login as Admin</button>
    </form>

    <hr/>

    <form action="/user/login" method="post">
        <h3>User Login</h3>
        <input type="text" name="username" placeholder="User Username">
        <input type="password" name="password" placeholder="Password">
        <button type="submit">Login as User</button>
    </form>

    <a href="/register">Create an Account</a>
</div>

</body>
</html>
