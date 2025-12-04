<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Available Songs</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
</head>
<body>

<div class="song-list-wrapper">

    <h2 class="song-list-title">Available Songs</h2>

    <div class="song-list-top-actions">
        <a href="/songs/add">
            <button class="sl-btn-primary">Add New Song</button>
        </a>
    </div>

    <div class="song-list-table-container">
        <table class="song-list-table" border="1" cellpadding="8">
            <thead>
                <tr>
                    <th>ID</th>            
                    <th>Title</th>            
                    <th>Genre</th>      
                    <th>Music Director</th>
                    <th>Singer</th>
                    <th>Release Date</th>
                    <th>Album</th>
                    <th>Type</th>
                    <th>Status</th>
                    <th>Play</th>
                    <th>Actions</th>
                </tr>
            </thead>

            <tbody>
            <c:forEach var="song" items="${songs}">
                <tr>
                    <td>${song.libraryId}</td>            
                    <td>${song.songTitle}</td>            
                    <td>${song.genre}</td>            
                    <td>${song.musicDirector}</td>
                    <td>${song.singer}</td>
                    <td>${song.releaseDate}</td>
                    <td>${song.albumName}</td>
                    <td>${song.songType}</td>
                    <td>${song.songStatus}</td>
			<td>
    <c:if test="${not empty song.fileName}">
        <audio controls style="width:200px;">
            <source src="${pageContext.request.contextPath}/songs/play/${song.libraryId}">
        </audio>
    </c:if>	
				</td>
                    <td>
                        <a class="sl-action-link" href="/songs/edit/${song.libraryId}">Edit</a> |
                        <a class="sl-action-link" href="/songs/delete/${song.libraryId}">Delete</a>
                    </td>
                    
                    
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="song-list-bottom-actions">
        <a href="/admin/dashboard">
            <button class="sl-btn-secondary">Back to Dashboard</button>
        </a>
    </div>

</div>

</body>
</html>
