<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>

<div class="dashboard-container">
    <h2>Admin Dashboard</h2>

   <a href="/songs"><button>Show All Songs</button></a>

<a href="/songs/add"><button>Add Song</button></a>
   
    <form action="/admin/deleteAccount" method="post">
    <input type="hidden" name="adminId" value="${admin.adminId}">
    <button type="submit">Delete My Account</button>
	</form>
	
   <a href="/admin/update-page?id=${admin.adminId}">Update My Profile</a><br/><br/>


    <a href="/"><button style="background:#333;">Logout</button></a>
</div>

</body>
</html>
