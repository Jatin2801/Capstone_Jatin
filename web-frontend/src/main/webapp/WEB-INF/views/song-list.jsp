<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html><head><title>Songs</title>
<link rel="stylesheet" href="/resources/css/style.css"></head>
<body>

<div class="content-block fade">
<h2>Songs Library</h2>

<div class="top-action-row">
    <a href="/admin/dashboard"><button class="btn-outline">⬅ Back</button></a>
    <a href="/songs/add"><button>+ Add New</button></a>
</div>

<table class="table-dark">
<thead><tr>
    <th>ID</th><th>Title</th><th>Singer</th><th>Genre</th>
    <th>Type</th><th>Status</th><th>Action</th>
</tr></thead>
<tbody>
<c:forEach var="s" items="${songs}">
<tr>
<td>${s.libraryId}</td>
<td>${s.songTitle}</td>
<td>${s.singer}</td>
<td>${s.genre}</td>
<td>${s.songType}</td>
<td>${s.songStatus}</td>
<td>
<a href="/songs/edit/${s.libraryId}">Edit</a> |
<a href="/songs/delete/${s.libraryId}" style="color:#ff4b4b;">Delete</a>
</td>
</tr>
</c:forEach>
</tbody>
</table>
</div>

</body></html>
