<html>
<body>
<h2>Update Admin Profile</h2>

<form action="/admin/update" method="post">

    <input type="hidden" name="adminId" value="${admin.adminId}" />

    Name: <input type="text" name="adminName" value="${admin.adminName}"><br/>
    Username: <input type="text" name="username" value="${admin.username}"><br/>
    Password: <input type="text" name="password" value="${admin.password}"><br/>
    Email: <input type="text" name="email" value="${admin.email}"><br/>
    Mobile: <input type="text" name="mobileNo" value="${admin.mobileNo}"><br/>
  

    <button type="submit">Update</button>
</form>

</body>
</html>
