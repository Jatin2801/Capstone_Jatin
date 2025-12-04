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

        <form action="${pageContext.request.contextPath}/songs/save"
              method="post"
              enctype="multipart/form-data">

            <c:if test="${not empty song.libraryId}">
                <input type="hidden" name="libraryId" value="${song.libraryId}" />
            </c:if>

            <div class="sf-row">
                <div class="sf-label">Title</div>
                <div class="sf-input">
                    <input type="text" name="songTitle" value="${song.songTitle}" required />
                </div>
            </div>

            <div class="sf-row">
                <div class="sf-label">Genre</div>
                <div class="sf-input">
                    <input type="text" name="genre" value="${song.genre}" />
                </div>
            </div>

            <div class="sf-row">
                <div class="sf-label">Music Director</div>
                <div class="sf-input">
                    <input type="text" name="musicDirector" value="${song.musicDirector}" />
                </div>
            </div>

            <div class="sf-row">
                <div class="sf-label">Singer</div>
                <div class="sf-input">
                    <input type="text" name="singer" value="${song.singer}" />
                </div>
            </div>

            <div class="sf-row">
                <div class="sf-label">Release Date</div>
                <div class="sf-input">
                    <input type="text" name="releaseDate" value="${song.releaseDate}" placeholder="eg. 2024-01-01" />
                </div>
            </div>

            <div class="sf-row">
                <div class="sf-label">Album Name</div>
                <div class="sf-input">
                    <input type="text" name="albumName" value="${song.albumName}" />
                </div>
            </div>

            <div class="sf-row">
                <div class="sf-label">Song Type</div>
                <div class="sf-input">
                    <select name="songType">
                        <option value="FREE"
                                ${song.songType == 'FREE' ? 'selected' : ''}>FREE</option>
                        <option value="PREMIUM"
                                ${song.songType == 'PREMIUM' ? 'selected' : ''}>PREMIUM</option>
                    </select>
                </div>
            </div>

            <div class="sf-row">
                <div class="sf-label">Status</div>
                <div class="sf-input">
                    <select name="songStatus">
                        <option value="AVAILABLE"
                                ${song.songStatus == 'AVAILABLE' ? 'selected' : ''}>AVAILABLE</option>
                        <option value="NOTAVAILABLE"
                                ${song.songStatus == 'NOTAVAILABLE' ? 'selected' : ''}>NOTAVAILABLE</option>
                    </select>
                </div>
            </div>

            <div class="sf-row">
                <div class="sf-label">Audio File</div>
                <div class="sf-input">
                    <input type="file" name="file" accept="audio/*" />
                    <c:if test="${not empty song.fileName}">
                        <div class="sf-file-info">
                            Current file: <strong>${song.fileName}</strong>
                        </div>
                    </c:if>
                </div>
            </div>

            <div class="sf-actions">
                <button type="submit">Save Song</button>
                <a href="${pageContext.request.contextPath}/songs">
                    <button type="button">Back</button>
                </a>
            </div>

        </form>

    </div>

</div>

</body>
</html>
