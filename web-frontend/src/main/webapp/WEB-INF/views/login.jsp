<%@ page contentType="text/html;charset=UTF-8" %>
<html><head><title>Login</title>
<link rel="stylesheet" href="/resources/css/style.css"></head>
<body>

<div class="auth-container fade">
<h2>Login</h2>

<form action="/admin/login" method="post">
    <h3>Admin Login</h3>
    <input name="username" placeholder="Admin Username" required/>
    <input type="password" name="password" placeholder="Password" required/>
    <button>Login as Admin</button>
</form>

<hr style="margin:18px 0;border-color:#333;">

<form action="/user/login" method="post">
    <h3>User Login</h3>
    <input name="username" placeholder="User Username" required/>
    <input type="password" name="password" placeholder="Password" required/>
    <button>Login as User</button>
</form>

<br>
<a href="/register">Create an Account</a>
</div>

</body></html>
