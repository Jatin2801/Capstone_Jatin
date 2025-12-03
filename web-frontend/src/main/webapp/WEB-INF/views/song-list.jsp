<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>


<html>
<head>
    <title>Songs</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css"/>
</head>
<body>

<h2>Song List</h2>

<a href="${pageContext.request.contextPath}/songs/add" class="btn">Add New Song</a>

<table class="table">
    <thead>
    <tr>
        <th>ID</th><th>Title</th><th>Genre</th><th>Type</th><th>Status</th><th>Actions</th>
    </tr>
    </thead>

    <tbody>
    <c:forEach items="${songs}" var="s">
        <tr>
            <td>${s.libraryId}</td>
            <td>${s.songTitle}</td>
            <td>${s.genre}</td>
            <td>${s.songType}</td>
            <td>${s.songStatus}</td>
            <td>
                <a href="${pageContext.request.contextPath}/songs/edit/${s.libraryId}">Edit</a> |
                <a href="${pageContext.request.contextPath}/songs/delete/${s.libraryId}">Delete</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>
