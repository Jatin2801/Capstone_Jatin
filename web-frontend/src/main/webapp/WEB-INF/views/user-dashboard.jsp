<html>
<head>
<title>User Dashboard</title>
</head>
<body>

<h2>Welcome User</h2>

<a href="/show-all-songs">Show All Songs</a><br/>
<a href="/show-free">Show Free Songs</a><br/>

<form action="/user/deleteAccount" method="post">
    <input type="hidden" name="userId" value="${userId}">
    <button type="submit">Delete My Account</button>
</form>
<hr>

<a href="/user/update-page?id=${user.userId}">Update My Profile</a><br/><br/>


</body>
</html>
