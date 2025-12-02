<html>
<head>
    <title>Register</title>
</head>
<body>

<h2>Add Admin</h2>
<form action="/admin/add" method="post">
    Name: <input type="text" name="adminName"><br/>
    Username: <input type="text" name="username"><br/>
    Password: <input type="password" name="password"><br/>
    Email: <input type="text" name="email"><br/>
    Mobile: <input type="text" name="mobileNo"><br/>
    <button type="submit">Add Admin</button>
</form>
<hr/>

<h2>Add User</h2>
<form action="/user/add" method="post">
    First Name: <input type="text" name="firstName"><br/>
    Last Name: <input type="text" name="lastName"><br/>
    Username: <input type="text" name="username"><br/>
    Password: <input type="password" name="password"><br/>
    Email: <input type="text" name="email"><br/>
    Mobile: <input type="text" name="mobile"><br/>
    City: <input type="text" name="city"><br/>
    State: <input type="text" name="state"><br/>
    Country: <input type="text" name="country"><br/>
	
    <button type="submit">Add User</button>
</form>
<hr>
<a href="/">Login</a>
</body>
</html>
