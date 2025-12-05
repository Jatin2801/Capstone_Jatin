<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>

<div class="dashboard-container fade admin-dash">

    <div class="dash-header">
        <div class="dash-title-block">
            <h2 class="dash-title-main">Admin Dashboard</h2>
            <p class="dash-title-sub">
                Hi, ${admin.adminName} 👋 Manage your music library and account.
            </p>
        </div>

        <a href="/">
            <button class="btn-outline dash-logout">Logout</button>
        </a>
    </div>

    <div class="dash-grid">
        <a href="/songs" class="dash-card">
            <div class="dash-card-title">Songs Library</div>
            <div class="dash-card-sub">View, search and manage all songs.</div>
        </a>

        <a href="/songs/add" class="dash-card">
            <div class="dash-card-title">Add Song</div>
            <div class="dash-card-sub">Upload a new track to the library.</div>
        </a>

        <a href="/admin/update-page?id=${admin.adminId}" class="dash-card">
            <div class="dash-card-title">Update Profile</div>
            <div class="dash-card-sub">Edit your admin details and credentials.</div>
        </a>
    </div>

    <div class="dash-danger">
        <h3>Danger Zone</h3>
        <p>Deleting your account is permanent and cannot be undone.</p>
        <form action="/admin/deleteAccount" method="post">
            <input type="hidden" name="adminId" value="${admin.adminId}"/>
            <button type="submit" class="danger-btn">Delete My Account</button>
        </form>
    </div>

</div>

</body>
</html>
