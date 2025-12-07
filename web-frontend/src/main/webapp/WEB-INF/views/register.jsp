<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Register</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<div style="margin-left:15px ; margin-top:5px">
        <a href="/"><button class="btn-outline">⬅ Back</button></a>
    </div>
<div class="auth-container fade" style="margin-top: -30px">

    <h2>Create Account</h2>
    <p style="color:green;">${msg}</p>
    <p style="color:red;">${error}</p>

    <div class="switch-box">
        <button id="adminTab" class="switch-btn active">Admin</button>
        <button id="userTab" class="switch-btn">User</button>
    </div>

    <div class="form-slider">

        <form id="adminForm" class="register-slide" action="${pageContext.request.contextPath}/admin/add" method="post">

            <div class="field"><label>Full Name</label>
            <input name="adminName" placeholder="Enter Full Name" required/></div>

            <div class="field"><label>Username</label>
            <input name="username" placeholder="Enter Username" required/></div>

            <div class="field"><label>Password</label>
            <input type="password" name="password" placeholder="Enter Password" required/></div>

            <div class="field"><label>Email</label>
            <input type="email" name="email" placeholder="Enter Email Address" required/></div>

            <div class="field"><label>Mobile No</label>
            <input name="mobileNo" placeholder="Enter Mobile Number" required/></div>

            <button>Create Admin</button>
        </form>

        <form id="userForm" class="register-slide" action="${pageContext.request.contextPath}/user/add" method="post">

            <div class="field"><label>First Name</label>
            <input name="firstName" placeholder="Enter First Name" required/></div>

            <div class="field"><label>Last Name</label>
            <input name="lastName" placeholder="Enter Last Name" required/></div>

            <div class="field"><label>Username</label>
            <input name="username" placeholder="Choose Username" required/></div>

            <div class="field"><label>Password</label>
            <input type="password" name="password" placeholder="Enter Password" required/></div>

            <div class="field"><label>Email</label>
            <input name="email" placeholder="Enter Email" required/></div>

            <div class="field"><label>Mobile No</label>
            <input name="mobile" placeholder="Enter Mobile Number" required/></div>

            <div class="field"><label>City</label>
            <input name="city" placeholder="City"/></div>

            <div class="field"><label>State</label>
            <input name="state" placeholder="State"/></div>

            <div class="field"><label>Country</label>
            <input name="country" placeholder="Country"/></div>

            <button>Create User</button>
        </form>

    </div>

</div>

<script>
let admin = document.getElementById("adminForm");
let user  = document.getElementById("userForm");
function adjustHeight(){
    let slider = document.querySelector(".form-slider");
    let activeForm = document.querySelector(".switch-btn.active").id === "adminTab" ? admin : user;
    slider.style.height = activeForm.offsetHeight + "px";
}

let adminTab = document.getElementById("adminTab");
let userTab  = document.getElementById("userTab");

function slideAdmin(){
    admin.style.marginLeft = "0px";
    user.style.marginLeft  = "-1200px";

    adminTab.classList.add("active");
    userTab.classList.remove("active");

    adjustHeight();
}

function slideUser(){
    admin.style.marginLeft = "1200px";
    user.style.marginLeft  = "0px";

    adminTab.classList.remove("active");
    userTab.classList.add("active");

    adjustHeight();
}
adminTab.onclick = slideAdmin;
userTab.onclick  = slideUser;
window.onload = adjustHeight; 
</script>

</body>
</html>
