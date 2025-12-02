<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>User Dashboard</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>

<div class="dashboard-container">
    <h2>User Dashboard</h2>

    <a href="/show-all-songs"><button>Show All Songs</button></a>
    <a href="/show-free"><button>Show Free Songs</button></a>
   <form action="/user/deleteAccount" method="post">
    <input type="hidden" name="userId" value="${userId}">
    <button type="submit">Delete My Account</button>
</form>
    
<a href="/user/update-page?id=${user.userId}">Update My Profile</a><br/><br/>

    <a href="/"><button style="background:#333;">Logout</button></a>
</div>

</body>
</html>
