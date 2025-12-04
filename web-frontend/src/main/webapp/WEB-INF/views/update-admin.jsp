<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Update Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>

<div class="update-container fade">
    <h2>Update Admin</h2>

    <form action="${pageContext.request.contextPath}/admin/update" method="post" class="update-form">

        <input type="hidden" name="adminId" value="${admin.adminId}" />

        <div class="field">
            <label>Admin Name</label>
            <input name="adminName" value="${admin.adminName}" placeholder="Enter Admin Name"/>
        </div>

        <div class="field">
            <label>Username</label>
            <input name="username" value="${admin.username}" placeholder="Enter Username"/>
        </div>

        <div class="field">
            <label>Password</label>
            <input name="password" value="${admin.password}" placeholder="Enter Password"/>
        </div>

        <div class="field">
            <label>Email</label>
            <input name="email" value="${admin.email}" placeholder="Enter Email Address"/>
        </div>

        <div class="field">
            <label>Mobile No.</label>
            <input name="mobile" value="${admin.mobile}" placeholder="Enter Mobile Number"/>
        </div>

        <button class="update-save">Save</button>
    </form>
</div>

</body>
</html>
