<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>My Playlists</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>

<div class="content-block fade">

    <h2 style="font-size:28px;margin-bottom:25px;text-align:center;">🎶 My Playlists</h2>

    <!-- CREATE NEW PLAYLIST -->
    <form action="/playlists/create" method="post" style="text-align:center;margin-bottom:25px;">
        <input type="hidden" name="userId" value="${userId}">
        <input name="name" placeholder="Enter Playlist Name"
               style="width:280px;padding:10px;border-radius:8px;background:#222;border:none;color:#fff;font-size:15px;">
        <button style="margin-left:10px;">+ Create</button>
    </form>

    <!-- PLAYLIST TABLE -->
    <table class="table-dark" style="margin-top:10px;">
        <thead>
            <tr>
                <th>ID</th>
                <th>Playlist Name</th>
                <th style="text-align:center;">Actions</th>
            </tr>
        </thead>

        <tbody>
        <c:forEach var="p" items="${playlists}">
            <tr>
                <td>${p.playlistId}</td>
                <td>${p.name}</td>

                <td style="text-align:center;">
                    <a href="/playlists/view/${p.playlistId}?userId=${userId}">Open</a> &nbsp;|&nbsp;
                    <a style="color:#ff4b4b;font-weight:700;"
                       href="/playlists/delete/${p.playlistId}?userId=${userId}">
                       Delete
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Back to user dashboard -->
    <div style="margin-top:25px;text-align:center;">
        <a href="/user/dashboard"><button class="btn-outline">⬅ Back</button></a>
    </div>

</div>

</body>
</html>
