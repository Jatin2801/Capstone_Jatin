<%@ page contentType="text/html;charset=UTF-8" %>
<html><head><title>Admin Dashboard</title>
<link rel="stylesheet" href="/resources/css/style.css"></head>
<body>

<div class="dashboard-container fade">
<h2>Admin Dashboard</h2>

<div class="btn-grid">
    <a href="/songs"><button>Show All Songs</button></a>
    <a href="/songs/add"><button>Add Song</button></a>
</div>

<br>
<form action="/admin/deleteAccount" method="post">
    <input type="hidden" name="adminId" value="${admin.adminId}"/>
    <button>Delete My Account</button>
</form>

<br>
<a href="/admin/update-page?id=${admin.adminId}">Update My Profile</a>

<br><br>
<a href="/"><button class="btn-outline">Logout</button></a>
</div>

</body></html>
