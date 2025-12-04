<%@ page contentType="text/html;charset=UTF-8" %>
<html><head><title>Update Admin</title>
<link rel="stylesheet" href="../resources/css/style.css"></head>
<body>

<div class="update-container fade">
    <h2>Update Admin</h2>
    <form action="../admin/update" method="post">
        <input name="adminName" value="${admin.adminName}" placeholder="Name"/>
        <input name="username" value="${admin.username}" placeholder="Username"/>
        <input name="password" value="${admin.password}" placeholder="Password"/>
        <button>Save</button>
    </form>
</div>

</body></html>
