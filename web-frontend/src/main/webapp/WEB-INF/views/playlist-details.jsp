<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<body>
<h2>Playlist: ${playlist.name}</h2>

<h3>Songs in Playlist</h3>
<table border="1">
<tr><th>ID</th><th>Title</th><th>Play</th><th>Action</th></tr>
<c:forEach var="s" items="${songsInPlaylist}">
<tr>
    <td>${s.libraryId}</td>
    <td>${s.songTitle}</td>
    <td>
    <c:if test="${not empty s.fileName}">
        <audio controls style="width:200px;">
            <source src="${pageContext.request.contextPath}/songs/play/${s.libraryId}">
        </audio>
    </c:if>	
				</td>
    <td><a href="/playlists/remove/${playlist.playlistId}/${s.libraryId}?userId=${userId}">Remove</a></td>
</tr>
</c:forEach>
</table>

<h3>Add Songs</h3>
<table border="1">
<tr><th>ID</th><th>Title</th><th>Type</th><th>Status</th><th>Action</th></tr>
<c:forEach var="s" items="${allSongs}">
<tr>
    <td>${s.libraryId}</td>
    <td>${s.songTitle}</td>
    <td>${s.songType}</td>
    <td>${s.songStatus}</td>

    <td>
        <c:choose>
            <c:when test="${s.songStatus == 'NOTAVAILABLE'}">
                Not Available
            </c:when>

            <c:when test="${s.songType == 'PREMIUM'}">
                <form method="post" action="/playlists/buy-and-add/${playlist.playlistId}/${s.libraryId}">
                    <input type="hidden" name="userId" value="${userId}" />
                    <button>Buy & Add</button>
                </form>
            </c:when>

            <c:otherwise>
                <form method="post" action="/playlists/add/${playlist.playlistId}/${s.libraryId}">
                    <input type="hidden" name="userId" value="${userId}" />
                    <button>Add</button>
                </form>
            </c:otherwise>
        </c:choose>
    </td>
</tr>
</c:forEach>
</table>

</body>
</html>
