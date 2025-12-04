<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Available Songs</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
</head>
<body>

<div class="song-list-wrapper">

    <div class="song-list-header">
        <h2 class="song-list-title">Available Songs</h2>
        <div class="song-list-top-actions">
            <a href="${pageContext.request.contextPath}/songs/add">
                <button class="sl-btn-primary">+ Add Song</button>
            </a>
        </div>
    </div>

    <div class="song-list-table-container">
        <c:choose>
            <c:when test="${empty songs}">
                <div class="empty-state">
                    <p>No songs found. Click “Add Song” to upload your first track.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table class="song-list-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Singer</th>
                        <th>Genre</th>
                        <th>Type</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="s" items="${songs}">
                        <tr>
                            <td>${s.libraryId}</td>
                            <td>${s.songTitle}</td>
                            <td>${s.singer}</td>
                            <td>${s.genre}</td>
                            <td>
                                <span class="pill pill-${s.songType}">
                                    ${s.songType}
                                </span>
                            </td>
                            <td>
                                <span class="status-badge status-${s.songStatus}">
                                    ${s.songStatus}
                                </span>
                            </td>
                            <td>
                                <a class="sl-action-link"
                                   href="${pageContext.request.contextPath}/songs/play/${s.libraryId}">
                                    Play
                                </a>
                                |
                                <a class="sl-action-link"
                                   href="${pageContext.request.contextPath}/songs/edit/${s.libraryId}">
                                    Edit
                                </a>
                                |
                                <a class="sl-action-link sl-action-danger"
                                   href="${pageContext.request.contextPath}/songs/delete/${s.libraryId}">
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

    <div class="song-list-bottom-actions">
        <a href="${pageContext.request.contextPath}/admin/dashboard">
            <button class="sl-btn-secondary">Back to Dashboard</button>
        </a>
    </div>

</div>

</body>
</html>
