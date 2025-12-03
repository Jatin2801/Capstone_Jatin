<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>${mode}</title>
</head>
<body>

<h2>${mode}</h2>

<form method="post" action="/songs/save">

    <!-- Hidden PK -->
    <input type="hidden" name="libraryId" value="${song.libraryId}" />

    <label>Song Title:</label>
    <input type="text" name="songTitle" value="${song.songTitle}" required /><br/><br/>

    <label>Genre:</label>
    <input type="text" name="genre" value="${song.genre}" required /><br/><br/>

    <label>Music Director:</label>
    <input type="text" name="musicDirector" value="${song.musicDirector}" required /><br/><br/>

    <label>Singer:</label>
    <input type="text" name="singer" value="${song.singer}" required /><br/><br/>

    <label>Release Date:</label>
    <input type="text" name="releaseDate" value="${song.releaseDate}" placeholder="YYYY-MM-DD" required /><br/><br/>

    <label>Album Name:</label>
    <input type="text" name="albumName" value="${song.albumName}" required /><br/><br/>

    <label>Song Type:</label>
    <select name="songType" required>
        <option value="FREE" ${song.songType == 'FREE' ? 'selected' : ''}>FREE</option>
        <option value="PREMIUM" ${song.songType == 'PREMIUM' ? 'selected' : ''}>PREMIUM</option>
    </select>
    <br/><br/>

    <label>Song Status:</label>
    <select name="songStatus" required>
        <option value="AVAILABLE" ${song.songStatus == 'AVAILABLE' ? 'selected' : ''}>AVAILABLE</option>
        <option value="NOTAVAILABLE" ${song.songStatus == 'NOTAVAILABLE' ? 'selected' : ''}>NOT AVAILABLE</option>
    </select>
    <br/><br/>

    <button type="submit">Save Song</button>
</form>

<br/>

<a href="/songs">
    <button>Back to Song List</button>
</a>

</body>
</html>
