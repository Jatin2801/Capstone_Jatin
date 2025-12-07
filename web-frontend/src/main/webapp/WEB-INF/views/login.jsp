<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Login</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>

<body>

<div class="login-wrapper fade" style="margin-top:-20px">

    <h1>Login</h1>
    <p style="color:red;text-align:center;">${error}</p>
    <p style="color:green;text-align:center;">${msg}</p>
    <div class="switch-box" style="margin-top:25px;">
        <button id="userTab"  class="switch-btn active">User</button>
        <button id="adminTab" class="switch-btn">Admin</button>
    </div>

    <div class="form-slider login-slider">

        <form id="userLogin" class="register-slide" action="${pageContext.request.contextPath}/user/login" method="post">

            <div class="field"><label>Username</label>
            <input type="text" name="username" placeholder="Enter Username" required></div>

            <div class="field"><label>Password</label>
            <input type="password" name="password" placeholder="Enter Password" required></div>

            <button class="login-btn">Login as User</button>
        </form>

        <form id="adminLogin" class="register-slide" action="${pageContext.request.contextPath}/admin/login" method="post" 
              style="margin-left:1200px;">

            <div class="field"><label>Admin Username</label>
            <input type="text" name="username" placeholder="Enter Admin Username" required></div>

            <div class="field"><label>Password</label>
            <input type="password" name="password" placeholder="Enter Admin Password" required></div>

            <button class="login-btn">Login as Admin</button>
        </form>

    </div>

    <a href="/register" class="create-link" style="margin-top:25px;display:block;">Create an Account</a>
</div>

<script>
let uForm = document.getElementById("userLogin");
let aForm = document.getElementById("adminLogin");
let uTab  = document.getElementById("userTab");
let aTab  = document.getElementById("adminTab");

function resize(){
    document.querySelector(".login-slider").style.height =
        (uTab.classList.contains("active") ? uForm.offsetHeight : aForm.offsetHeight) + "px";
}

function showUser(){
    uForm.style.marginLeft = "0px";
    aForm.style.marginLeft = "1200px";
    uTab.classList.add("active");
    aTab.classList.remove("active");
    resize();
}

function showAdmin(){
    uForm.style.marginLeft = "-1200px";
    aForm.style.marginLeft = "0px";
    aTab.classList.add("active");
    uTab.classList.remove("active");
    resize();
}

uTab.onclick = showUser;
aTab.onclick = showAdmin;
window.onload = resize;
</script>

</body>
</html>
