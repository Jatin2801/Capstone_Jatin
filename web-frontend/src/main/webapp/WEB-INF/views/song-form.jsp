<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>${mode}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css"/>
</head>
<body>

<h2>${mode}</h2>

<form method="post" action="${pageContext.request.contextPath}/songs/save">

    <input type="hidden" name="libraryId" value="${song.libraryId}"/>

    <label>Title</label>
    <input name="songTitle" value="${song.songTitle}" required/>

    <label>Song ID</label>
    <input name="songId" value="${song.songId}"/>

    <label>Description</label>
    <input name="songDesc" value="${song.songDesc}"/>

    <label>Genre</label>
    <input name="genre" value="${song.genre}"/>

    <label>Duration (seconds)</label>
    <input name="duration" type="number" value="${song.duration}"/>

    <label>Music Director</label>
    <input name="musicDirector" value="${song.musicDirector}"/>

    <label>Singer</label>
    <input name="singer" value="${song.singer}"/>

    <label>Release Date</label>
    <input type="date" name="releaseDate" value="${song.releaseDate}"/>

    <label>Album</label>
    <input name="albumName" value="${song.albumName}"/>

    <label>Song Type</label>
    <select name="songType">
        <option value="FREE"     ${song.songType=='FREE'?'selected':''}>FREE</option>
        <option value="PREMIUM"  ${song.songType=='PREMIUM'?'selected':''}>PREMIUM</option>
    </select>

    <label>Status</label>
    <select name="songStatus">
        <option value="AVAILABLE"      ${song.songStatus=='AVAILABLE'?'selected':''}>AVAILABLE</option>
        <option value="NOTAVAILABLE"   ${song.songStatus=='NOTAVAILABLE'?'selected':''}>NOTAVAILABLE</option>
    </select>

    <button type="submit" class="btn">Save</button>

</form>

</body>
</html>
