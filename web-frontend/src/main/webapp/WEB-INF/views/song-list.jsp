<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Available Songs</title>
</head>
<body>

<h2>Available Songs</h2>

<a href="/songs/add">
    <button>Add New Song</button>
</a>

<table border="1" cellpadding="8">
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
                <a href="/songs/edit/${song.libraryId}">Edit</a> |
                <a href="/songs/delete/${song.libraryId}">Delete</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<a href="/admin/dashboard">
    <button>Back to Dashboard</button>
</a>

</body>
</html>
