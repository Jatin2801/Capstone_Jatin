<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Update User</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>

<div class="update-container fade">
    <h2>Update User</h2>

    <form action="${pageContext.request.contextPath}/user/update" method="post" class="update-form">

        <input type="hidden" name="userId" value="${user.userId}"/>

        <div class="field">
            <label>First Name</label>
            <input name="firstName" value="${user.firstName}" placeholder="Enter First Name"/>
        </div>

        <div class="field">
            <label>Last Name</label>
            <input name="lastName" value="${user.lastName}" placeholder="Enter Last Name"/>
        </div>
        
        <div class="field">
            <label>Username</label>
            <input name="username" value="${user.username}" placeholder="Enter Mobile Number"/>
        </div>

        <div class="field">
            <label>Email</label>
            <input name="email" value="${user.email}" placeholder="Enter Email"/>
        </div>

        <div class="field">
            <label>Password</label>
            <input name="password" value="${user.password}" placeholder="Enter New Password"/>
        </div>

        <div class="field">
            <label>Mobile</label>
            <input name="mobile" value="${user.mobile}" placeholder="Enter Mobile Number"/>
        </div>
		
		<div class="field">
            <label>City</label>
            <input name="city" value="${user.city}" placeholder="Enter Mobile Number"/>
        </div>
		<div class="field">
            <label>State</label>
            <input name="state" value="${user.state}" placeholder="Enter Mobile Number"/>
        </div>
		<div class="field">
            <label>Country</label>
            <input name="country" value="${user.country}" placeholder="Enter Mobile Number"/>
        </div>
		
			
        <button class="update-save">Save</button>
    </form>

</div>

</body>
</html>
