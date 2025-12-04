<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>My Playlists</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
</head>
<body>

<div class="user-playlists-wrapper">

    <div class="user-playlists-header">
        <div>
            <a href="${pageContext.request.contextPath}/user-dashboard">
                <button type="button" class="sl-btn-secondary">&larr; Dashboard</button>
            </a>
        </div>
        <h2 class="user-playlists-title">My Playlists</h2>
    </div>

    <div class="user-playlists-create">
        <form method="post" action="${pageContext.request.contextPath}/playlists/create" class="up-create-form">
            <input type="text" name="name" placeholder="Playlist name" required class="up-input" />
            <input type="hidden" name="userId" value="${userId}" />
            <button type="submit" class="up-btn-primary">+ Create Playlist</button>
        </form>
    </div>

    <div class="playlist-table-container">
        <c:choose>
            <c:when test="${empty playlists}">
                <div class="empty-state">
                    <p>You don’t have any playlists yet. Create your first one above!</p>
                </div>
            </c:when>
            <c:otherwise>
                <table class="playlist-table">
                    <thead>
                    <tr>
                        
                        <th>Name</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="p" items="${playlists}">
                        <tr>
                            
                            <td>${p.name}</td>
                            <td>
                                <a class="sl-action-link"
                                   href="${pageContext.request.contextPath}/playlists/view/${p.playlistId}?userId=${userId}">
                                    Open
                                </a>
                                |
                                <a class="sl-action-link sl-action-danger"
                                   href="${pageContext.request.contextPath}/playlists/delete/${p.playlistId}?userId=${userId}">
                                    Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

</div>

</body>
</html>
