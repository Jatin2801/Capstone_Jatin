<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>User Dashboard</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>

<div class="dashboard-container fade admin-dash">  <!-- using same styling -->

    <!-- Header -->
    <div class="dash-header">
        <div class="dash-title-block">
            <h2 class="dash-title-main">User Dashboard</h2>
            <p class="dash-title-sub">
                Welcome back, ${user.firstName} 👋 Manage playlists & profile.
            </p>
        </div>

        <a href="/"><button class="btn-outline dash-logout">Logout</button></a>
    </div>

    <!-- Cards Section -->
    <div class="dash-grid">

        <a href="${pageContext.request.contextPath}/playlists/user/${user.userId}" class="dash-card">
            <div class="dash-card-title">My Playlists</div>
            <div class="dash-card-sub">View & play your saved songs.</div>
        </a>

        <a href="/user/update-page?id=${user.userId}" class="dash-card">
            <div class="dash-card-title">Update Profile</div>
            <div class="dash-card-sub">Edit your info & password.</div>
        </a>

    </div>

    <!-- Danger Zone -->
    <div class="dash-danger">
        <h3>Danger Zone</h3>
        <p>Deleting your account is permanent and cannot be undone.</p>

        <form action="/user/deleteAccount" method="post">
            <input type="hidden" name="userId" value="${user.userId}">
            <button type="submit" class="danger-btn">Delete My Account</button>
        </form>
    </div>

</div>

</body>
</html>
