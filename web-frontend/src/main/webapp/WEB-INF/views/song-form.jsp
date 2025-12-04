<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html><head><title>Add Song</title>
<link rel="stylesheet" href="/resources/css/style.css"></head>
<body>
<div class="top-action-row" style="margin-left:20px ">
    <a href="/admin/dashboard"><button class="btn-outline">⬅ Back</button></a>
    <a href="/songs/add"><button>+ Add New</button></a>
</div>
<div class="content-block fade" style="margin-top:-20px ">
<h2>Add Song</h2>

<form action="/songs/save" method="post" enctype="multipart/form-data">

    <c:if test="${not empty song.libraryId}">
        <input type="hidden" name="libraryId" value="${song.libraryId}">
    </c:if>

    <input name="songTitle" value="${song.songTitle}" placeholder="Title">
    <input name="genre" value="${song.genre}" placeholder="Genre">
    <input name="musicDirector" value="${song.musicDirector}" placeholder="Director">
    <input name="singer" value="${song.singer}" placeholder="Singer">
    <input name="releaseDate" value="${song.releaseDate}" placeholder="YYYY-MM-DD">
    <input name="albumName" value="${song.albumName}" placeholder="Album Name">

    <select name="songType">
        <option ${song.songType=='FREE'?'selected':''}>FREE</option>
        <option ${song.songType=='PREMIUM'?'selected':''}>PREMIUM</option>
    </select>

    <select name="songStatus">
        <option ${song.songStatus=='AVAILABLE'?'selected':''}>AVAILABLE</option>
        <option ${song.songStatus=='NOTAVAILABLE'?'selected':''}>NOTAVAILABLE</option>
    </select>

    <input type="file" name="file" accept="audio/*">

    <button class="save-btn">Save</button>
</form>
</div>

</body></html>
