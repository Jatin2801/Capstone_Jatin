<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>${playlist.name}</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>

<div class="playlist-container fade">

    <h1 class="play-title">${playlist.name}</h1>
    <p class="play-sub">Enjoy your music 🎧</p>

    <!-- PLAYER ONLY IF SONGS EXIST -->
    <c:if test="${not empty songsInPlaylist}">
        <div class="player-bar">
            <button id="prevBtn"     class="player-btn">⏮</button>
            <button id="playBtn"     class="player-btn">▶</button>
            <button id="stopBtn"     class="player-btn">⏹</button>
            <button id="nextBtn"     class="player-btn">⏭</button>
            <button id="repeatBtn"   class="player-btn">🔁</button>
            <button id="shuffleBtn"  class="player-btn">🔀</button>
        </div>
    </c:if>

    <!-- ================= SONGS INSIDE PLAYLIST ================= -->

    <table class="table-dark" id="playlistTable" style="margin-top:25px;">
        <thead>
        <tr>
            <th>#</th><th>Title</th><th>Singer</th><th>Type</th><th>Play</th><th>Remove</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="s" items="${songsInPlaylist}" varStatus="i">
            <tr class="song-row" data-src="/songs/play/${s.libraryId}">
                <td>${i.index + 1}</td>
                <td>${s.songTitle}</td>
                <td>${s.singer}</td>
                <td>${s.songType}</td>

                <td><button class="small-play-btn">▶</button></td>

                <td>
                    <a href="/playlists/remove/${playlist.playlistId}/${s.libraryId}?userId=${userId}"
                       style="color:#ff4b4b;font-weight:700;">Remove</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Player UI -->
    <div class="glass-player"><audio id="player" controls style="width:100%;"></audio></div>


    <!-- ================= ADD SONG SECTION RESTORED ================= -->

    <h2 style="margin-top:40px;margin-bottom:12px;">Add Songs 🎶</h2>

    <table class="table-dark">
        <thead>
        <tr>
            <th>Title</th><th>Type</th><th>Status</th><th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="s" items="${allSongs}">
            <tr>
                <td>${s.songTitle}</td>
                <td>${s.songType}</td>
                <td>${s.songStatus}</td>

                <td>
                    <c:choose>

                        <c:when test="${s.songStatus == 'NOTAVAILABLE'}">
                            <span style="color:#777;">Not Available</span>
                        </c:when>

                        <c:when test="${s.songType == 'PREMIUM'}">
                            <form method="post" action="/playlists/buy-and-add/${playlist.playlistId}/${s.libraryId}">
                                <input type="hidden" name="userId" value="${userId}" />
                                <button style="background:#f9c305;color:black;">Buy + Add</button>
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
        </tbody>
    </table>

    <div style="text-align:center;margin-top:25px;">
        <a href="/user/dashboard"><button class="btn-outline">⬅ Back</button></a>
    </div>

</div>


<!-- ================== PLAYER LOGIC ================== -->
<script>
const audio  = document.getElementById("player");
const rows   = [...document.querySelectorAll(".song-row")];
let index    = 0;
let repeat   = false;

function playSong() {
    rows.forEach(r => r.classList.remove("playing"));
    rows[index].classList.add("playing");
    audio.src = rows[index].dataset.src;
    audio.play();
}

rows.forEach((row,i) => row.querySelector(".small-play-btn").onclick = () => { index=i; playSong(); });

playBtn.onclick    = () => playSong();
stopBtn.onclick    = () => audio.pause();
nextBtn.onclick    = () => { index=(index+1)%rows.length; playSong(); };
prevBtn.onclick    = () => { index=(index-1+rows.length)%rows.length; playSong(); };
shuffleBtn.onclick = () => { index=Math.floor(Math.random()*rows.length); playSong(); };
repeatBtn.onclick  = () => repeat = !repeat;

audio.onended = () => repeat ? playSong() : nextBtn.click();
</script>

</body>
</html>
