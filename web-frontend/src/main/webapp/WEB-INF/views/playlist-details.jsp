<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Playlist - ${playlist.name}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
</head>
<body>

<div class="playlist-wrapper">

    <!-- Top bar -->
    <div class="playlist-header">
        <div class="playlist-header-left">
            <a href="${pageContext.request.contextPath}/playlists/user/${userId}">
                <button type="button" class="sl-btn-secondary">&larr; My Playlists</button>
            </a>
        </div>
        <div class="playlist-header-right">
            <h2 class="playlist-title">${playlist.name}</h2>
           
        </div>
    </div>

    <!-- Songs in playlist -->
    <div class="playlist-section">
        <h3 class="playlist-section-title">Songs in this Playlist</h3>

        <c:choose>
            <c:when test="${empty songsInPlaylist}">
                <div class="empty-state">
                    <p>No songs in this playlist yet. Use the section below to add some tracks 🎵</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="playlist-table-container">
                    <table class="playlist-table">
                        <thead>
                        <tr>
                            <th>Title</th>
                            <th>Singer</th>
                            <th>Type</th>
                            <th>Play</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="s" items="${songsInPlaylist}">
                            <tr>
                                <td>${s.songTitle}</td>
                                <td>${s.singer}</td>
                                <td>
                                    <span class="pill pill-${s.songType}">
                                        ${s.songType}
                                    </span>
                                </td>
                                <td>
                                    <c:if test="${not empty s.fileName}">
                                        <audio controls class="playlist-audio">
                                            <source src="${pageContext.request.contextPath}/songs/play/${s.libraryId}">
                                        </audio>
                                    </c:if>
                                </td>
                                <td>
                                    <a class="pill pill-danger"
                                       href="${pageContext.request.contextPath}/playlists/remove/${playlist.playlistId}/${s.libraryId}?userId=${userId}">
                                        Remove
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- All songs to add -->
    <div class="playlist-section">
        <h3 class="playlist-section-title">Add Songs</h3>

        <div class="playlist-table-container">
            <table class="playlist-table">
                <thead>
                <tr>
                    <th>Title</th>
                    <th>Type</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="s" items="${allSongs}">
                    <tr>
                        <td>${s.songTitle}</td>
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
                            <c:choose>
                                <c:when test="${s.songStatus == 'NOTAVAILABLE'}">
                                    <span class="badge-muted">Not Available</span>
                                </c:when>

                                <c:when test="${s.songType == 'PREMIUM'}">
                                    <form method="post"
                                          action="${pageContext.request.contextPath}/playlists/buy-and-add/${playlist.playlistId}/${s.libraryId}">
                                        <input type="hidden" name="userId" value="${userId}" />
                                        <button class="pill pill-primary" type="submit">
                                            Buy &amp; Add
                                        </button>
                                    </form>
                                </c:when>

                                <c:otherwise>
                                    <form method="post"
                                          action="${pageContext.request.contextPath}/playlists/add/${playlist.playlistId}/${s.libraryId}">
                                        <input type="hidden" name="userId" value="${userId}" />
                                        <button class="pill pill-primary" type="submit">
                                            Add
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</div>

</body>
</html>
