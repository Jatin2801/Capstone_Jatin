<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
<h2>Update User Profile</h2>

<form action="/user/update" method="post">

    <input type="hidden" name="userId" value="${user.userId}" />

    First Name: <input type="text" name="firstName" value="${user.firstName}"><br/>
    Last Name: <input type="text" name="lastName" value="${user.lastName}"><br/>
    Username: <input type="text" name="username" value="${user.username}"><br/>
    Password: <input type="text" name="password" value="${user.password}"><br/>
    Email: <input type="text" name="email" value="${user.email}"><br/>
    Mobile: <input type="text" name="mobile" value="${user.mobile}"><br/>
    City: <input type="text" name="city" value="${user.city}"><br/>
    State: <input type="text" name="state" value="${user.state}"><br/>
    Country: <input type="text" name="country" value="${user.country}"><br/>

    <button type="submit">Update</button>
</form>

</body>
</html>
