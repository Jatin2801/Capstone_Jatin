<html>
<head>
<title>Admin Dashboard</title>
</head>
<body>

<h2>Welcome Admin</h2>

<a href="/add-song">Add Song</a><br/>
<a href="/show-available">Show Available Songs</a><br/>
<a href="/show-free">Show Free Songs</a><br/>

<form action="/admin/deleteAccount" method="post">
    <input type="hidden" name="adminId" value="${adminId}">
    <button type="submit">Delete My Account</button>
</form>
<br>

<a href="/admin/update-page?id=${admin.adminId}">Update My Profile</a><br/><br/>


</body>
</html>
