<%@ page contentType="text/html;charset=UTF-8" %>
<html><head>
<title>Register</title>
<link rel="stylesheet" href="resources/css/style.css">
</head><body>

<div class="auth-container fade">
    <h2>Create Account</h2>

    <div class="switch-box">
        <div id="adminTab" class="switch-btn active">Admin</div>
        <div id="userTab" class="switch-btn">User</div>
    </div>

    <!-- ADMIN FORM -->
    <form id="adminForm" class="register-form active" action="admin/add" method="post">
        <input type="text" name="adminName" placeholder="Name" required/>
        <input type="text" name="username" placeholder="Username" required/>
        <input type="password" name="password" placeholder="Password" required/>
        <input type="email" name="email" placeholder="Email" required/>
        <input type="text" name="mobileNo" placeholder="Mobile" required/>
        <button>Create Admin</button>
    </form>

    <!-- USER FORM -->
    <form id="userForm" class="register-form" action="user/add" method="post">
        <input name="firstName" placeholder="First Name" required/>
        <input name="lastName" placeholder="Last Name" required/>
        <input name="username" placeholder="Username" required/>
        <input type="password" name="password" placeholder="Password" required/>
        <input name="email" placeholder="Email" required/>
        <input name="mobile" placeholder="Mobile" required/>
        <input name="city" placeholder="City"/>
        <input name="state" placeholder="State"/>
        <input name="country" placeholder="Country"/>
        <button>Create User</button>
    </form>
</div>

<script>
adminTab.onclick=()=>switchForm(true);userTab.onclick=()=>switchForm(false);
function switchForm(admin){
 adminForm.classList.toggle("active",admin);
 userForm.classList.toggle("active",!admin);
 adminTab.classList.toggle("active",admin);
 userTab.classList.toggle("active",!admin);
}
</script>

</body></html>
