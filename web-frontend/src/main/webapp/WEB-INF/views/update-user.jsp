<%@ page contentType="text/html;charset=UTF-8" %>
<html><head><title>Update User</title>
<link rel="stylesheet" href="../resources/css/style.css"></head>
<body>

<div class="update-container fade">
<h2>Update User</h2>

<form action="../user/update" method="post">
<input name="firstName" value="${user.firstName}"/>
<input name="lastName" value="${user.lastName}"/>
<input name="password" value="${user.password}"/>
<input name="email" value="${user.email}"/>
<input name="mobile" value="${user.mobile}"/>
<button>Save</button>
</form>

</div>
</body></html>
