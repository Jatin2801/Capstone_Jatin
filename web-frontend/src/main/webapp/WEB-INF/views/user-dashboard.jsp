<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>User Dashboard</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>

<div class="dashboard-container fade">
    <h2>User Dashboard</h2>

    <div class="btn-grid">
        <a href="/user/playlists"><button>Playlists</button></a>
    </div>

    <br>

    <form action="/user/delete" method="post">
        <input type="hidden" name="userId" value="${user.userId}">
        <button>Delete My Account</button>
    </form>

    <br>
    <a href="/user/update-page?id=${user.userId}">Update My Profile</a>

    <br><br>

    <!-- 🔥 Now same logout style as admin -->
    <a href="/"><button class="btn-outline">Logout</button></a>
</div>

</body>
</html>
