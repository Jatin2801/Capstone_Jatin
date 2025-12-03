<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>${mode}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
</head>
<body>

<div class="song-form-wrapper">

    <div class="song-form-card">

        <h2 class="song-form-title">${mode}</h2>

        <form method="post" action="/songs/save" class="song-form" enctype="multipart/form-data">


            <!-- Hidden PK -->
            <input type="hidden" name="libraryId" value="${song.libraryId}" />

            <div class="sf-row">
                <label class="sf-label">Song Title:</label>
                <input class="sf-input" type="text" name="songTitle" value="${song.songTitle}" required />
            </div>

            <div class="sf-row">
                <label class="sf-label">Genre:</label>
                <input class="sf-input" type="text" name="genre" value="${song.genre}" required />
            </div>

            <div class="sf-row">
                <label class="sf-label">Music Director:</label>
                <input class="sf-input" type="text" name="musicDirector" value="${song.musicDirector}" required />
            </div>

            <div class="sf-row">
                <label class="sf-label">Singer:</label>
                <input class="sf-input" type="text" name="singer" value="${song.singer}" required />
            </div>

            <div class="sf-row">
                <label class="sf-label">Release Date:</label>
                <input class="sf-input" type="text" name="releaseDate" value="${song.releaseDate}" placeholder="YYYY-MM-DD" required />
            </div>

            <div class="sf-row">
                <label class="sf-label">Album Name:</label>
                <input class="sf-input" type="text" name="albumName" value="${song.albumName}" required />
            </div>

            <div class="sf-row">
                <label class="sf-label">Song Type:</label>
                <select class="sf-input" name="songType" required>
                    <option value="FREE" ${song.songType == 'FREE' ? 'selected' : ''}>FREE</option>
                    <option value="PREMIUM" ${song.songType == 'PREMIUM' ? 'selected' : ''}>PREMIUM</option>
                </select>
            </div>

            <div class="sf-row">
                <label class="sf-label">Song Status:</label>
                <select class="sf-input" name="songStatus" required>
                    <option value="AVAILABLE" ${song.songStatus == 'AVAILABLE' ? 'selected' : ''}>AVAILABLE</option>
                    <option value="NOTAVAILABLE" ${song.songStatus == 'NOTAVAILABLE' ? 'selected' : ''}>NOT AVAILABLE</option>
                </select>
            </div>
            
            <div class="sf-field">
   				 <label>Upload MP3</label>
   				 <input class="sf-input" type="file" name="file" accept="audio/*" />
			</div>
            

            <div class="sf-actions">
                <button type="submit">Save Song</button>
                <a href="/songs"><button type="button">Back</button></a>
            </div>

        </form>

    </div>

</div>

</body>
</html>
