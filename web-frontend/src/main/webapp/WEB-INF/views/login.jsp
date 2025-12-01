<html>
<head>
    <title>Login</title>
</head>
<body>

<h2>Login Page</h2>

<form action="/admin/login" method="post">
    <h3>Admin Login</h3>
    Username: <input type="text" name="username"><br/>
    Password: <input type="password" name="password"><br/>
    <button type="submit">Login Admin</button>
</form>

<hr/>

<form action="/user/login" method="post">
    <h3>User Login</h3>
    Username: <input type="text" name="username"><br/>
    Password: <input type="password" name="password"><br/>
    <button type="submit">Login User</button>
</form>

<hr/>

<a href="/register">Register</a>

</body>
</html>
