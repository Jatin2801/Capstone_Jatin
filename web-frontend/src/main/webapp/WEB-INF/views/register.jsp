<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>

<div class="container register-container">
    <h2>Register</h2>

    <div class="register-toggle">
        <button type="button" id="adminToggle" class="toggle-btn active">
            Register as Admin
        </button>
        <button type="button" id="userToggle" class="toggle-btn">
            Register as User
        </button>
    </div>

    <!-- ADMIN FORM -->
    <form id="adminForm" class="register-form active" action="/admin/add" method="post">
        <h3>Admin Details</h3>
        <input type="text" name="adminName" placeholder="Name">
        <input type="text" name="username" placeholder="Username">
        <input type="password" name="password" placeholder="Password">
        <input type="text" name="email" placeholder="Email">
        <input type="text" name="mobileNo" placeholder="Mobile">
        <button type="submit">Create Admin</button>
    </form>

    <!-- USER FORM -->
    <form id="userForm" class="register-form" action="/user/add" method="post">
        <h3>User Details</h3>
        <input type="text" name="firstName" placeholder="First Name">
        <input type="text" name="lastName" placeholder="Last Name">
        <input type="text" name="username" placeholder="Username">
        <input type="password" name="password" placeholder="Password">
        <input type="text" name="email" placeholder="Email">
        <input type="text" name="mobile" placeholder="Mobile">
        <input type="text" name="city" placeholder="City">
        <input type="text" name="state" placeholder="State">
        <input type="text" name="country" placeholder="Country">
        <button type="submit">Create User</button>
    </form>

    <a href="/">Back to Login</a>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const adminToggle = document.getElementById('adminToggle');
        const userToggle = document.getElementById('userToggle');
        const adminForm = document.getElementById('adminForm');
        const userForm = document.getElementById('userForm');

        function showAdmin() {
            adminForm.classList.add('active');
            userForm.classList.remove('active');
            adminToggle.classList.add('active');
            userToggle.classList.remove('active');
        }

        function showUser() {
            userForm.classList.add('active');
            adminForm.classList.remove('active');
            userToggle.classList.add('active');
            adminToggle.classList.remove('active');
        }

        adminToggle.addEventListener('click', showAdmin);
        userToggle.addEventListener('click', showUser);
    });
</script>

</body>
</html>
