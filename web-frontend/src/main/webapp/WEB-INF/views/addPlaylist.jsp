<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Add Songs - ${playlist.name}</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>

<div style="margin-left:15px ; margin-top:15px">
    <a href="/playlists/view/${playlist.playlistId}?userId=${userId}">
        <button class="btn-outline">⬅ Back to Playlist</button>
    </a>
</div>

<div class="playlist-container fade">
    <h1 class="play-title">Add Songs to: ${playlist.name}</h1>
    <p class="play-sub">Search by song name, music director or singer.</p>

    <form method="get"
          action="/playlists/add/${playlist.playlistId}"
          class="top-action-row"
          style="margin-top:20px;">
        <input type="hidden" name="userId" value="${userId}" />

        <input type="text"
               name="keyword"
               value="${keyword}"
               placeholder="Search by title / director / singer"
               class="song-search-input" />

        <button type="submit">Search</button>

        <a href="/playlists/add/${playlist.playlistId}?userId=${userId}">
            <button type="button" class="btn-outline">Clear</button>
        </a>
    </form>

    <hr class="soft-divider"/>

    <h2 class="add-section-title">All Songs 🎶</h2>

    <table class="table-dark">
        <thead>
        <tr>
            <th>#</th>
            <th>Title</th>
            <th>Singer</th>
            <th>Type</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="s" items="${allSongs}" varStatus="i">
            <tr class="${s.alreadyInPlaylist ? 'row-added' : 'selectable'}">
                <td>${i.index + 1}</td>
                <td>${s.songTitle}</td>
                <td>${s.singer}</td>
                <td>${s.songType}</td>
                <td>${s.songStatus}</td>

                <td class="action-col">
                    <c:choose>
                        <c:when test="${s.alreadyInPlaylist}">
                            <span class="tag-added">&#10004; Already in Playlist</span>
                        </c:when>

                        <c:when test="${s.songStatus == 'NOTAVAILABLE'}">
                            <span style="color:#777;font-weight:600;">Not Available</span>
                        </c:when>

                        <c:when test="${s.songType == 'PREMIUM'}">
                            <form method="post"
                                  action="/playlists/buy-and-add/${playlist.playlistId}/${s.libraryId}">
                                <input type="hidden" name="userId" value="${userId}" />
                                <button>Buy + Add</button>
                            </form>
                        </c:when>

                        <c:otherwise>
                            <form method="post"
                                  action="/playlists/add/${playlist.playlistId}/${s.libraryId}">
                                <input type="hidden" name="userId" value="${userId}" />
                                <button>Add</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>

</body>
</html>
