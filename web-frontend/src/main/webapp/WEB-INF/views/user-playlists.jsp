<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<body>
<a href="${pageContext.request.contextPath}/user-dashboard">
    <button style="padding:8px 16px;"> Dashboard</button>
</a>
<br>
<h2>My Playlists</h2>

<form method="post" action="/playlists/create">
    <input type="text" name="name" placeholder="Playlist name" required />
    <input type="hidden" name="userId" value="${userId}" />
    <button type="submit">Create</button>
</form>

<table border="1">
    <tr><th>ID</th><th>Name</th><th>Actions</th></tr>
    <c:forEach var="p" items="${playlists}">
        <tr>
            <td>${p.playlistId}</td>
            <td>${p.name}</td>
            <td>
                <a href="/playlists/view/${p.playlistId}?userId=${userId}">Open</a> |
                <a href="/playlists/delete/${p.playlistId}?userId=${userId}">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
