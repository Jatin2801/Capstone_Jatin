<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>${playlist.name}</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
<div style="margin-left:15px ; margin-top:15px">
    <a href="/user/dashboard"><button class="btn-outline">⬅ Back</button></a>
</div>

<div class="playlist-container fade">

    <h1 class="play-title">${playlist.name}</h1>
    <p class="play-sub">Enjoy your music 🎧</p>

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

<form method="get"
      action="/playlists/view/${playlist.playlistId}"
      style="display:flex; justify-content:center; align-items:center; gap:14px; flex-wrap:wrap; margin:30px 0;">

    <input type="hidden" name="userId" value="${userId}" />

    <input type="text" name="songName" value="${songName}"
           placeholder="Search by Song"
           class="playlist-input" style="width:240px;" />

    <input type="text" name="musicDirector" value="${musicDirector}"
           placeholder="Search by Director"
           class="playlist-input" style="width:240px;" />

    <input type="text" name="album" value="${album}"
           placeholder="Search by Album"
           class="playlist-input" style="width:220px;" />

    <button type="submit">Search</button>

    <a href="/playlists/view/${playlist.playlistId}?userId=${userId}">
        <button type="button" class="btn-outline">Clear</button>
    </a>
</form>
    
    <table class="table-dark" style="margin-top:20px;">
        <thead>
        <tr>
            <th>#</th><th>Title</th><th>Singer</th><th>Director</th><th>Album</th><th>Type</th><th>Play</th><th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="s" items="${songsInPlaylist}" varStatus="i">
            <tr class="song-row" data-src="/songs/play/${s.libraryId}">
                <td>${i.index + 1}</td>
                <td>${s.songTitle}</td>
                <td>${s.singer}</td>
                <td>${s.musicDirector}</td>
                <td>${s.albumName}</td>
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

    <div class="glass-player">
        <audio id="player" controls style="width:100%;"></audio>
    </div>

    <!-- Button to go to Add Songs page -->
    <div style="margin-top:30px;">
        <a href="/playlists/add/${playlist.playlistId}?userId=${userId}">
            <button>+ Add Songs</button>
        </a>
    </div>

</div>

<script>
const audio = document.getElementById("player");
const rows  = [...document.querySelectorAll(".song-row")];

let currentIndex = -1;
let repeat = false;

function highlightRow() {
    rows.forEach((row, i) => {
        if (i === currentIndex) {
            row.classList.add("playing");
        } else {
            row.classList.remove("playing");
        }
    });
}

function loadSong(idx) {
    if (idx < 0 || idx >= rows.length) return;
    currentIndex = idx;
    const row = rows[currentIndex];
    if (!row) return;
    audio.src = row.dataset.src;       
    highlightRow();
}

function playCurrent() {
    if (rows.length === 0) return;
    if (currentIndex === -1) {
        loadSong(0);                   
    }
    audio.play();                      
}


rows.forEach((row, i) => {
    const btn = row.querySelector(".small-play-btn");
    if (!btn) return;
    btn.onclick = () => {
        loadSong(i);                   
        playCurrent();                 
    };
});

const playBtn    = document.getElementById("playBtn");
const stopBtn    = document.getElementById("stopBtn");
const nextBtn    = document.getElementById("nextBtn");
const prevBtn    = document.getElementById("prevBtn");
const shuffleBtn = document.getElementById("shuffleBtn");
const repeatBtn  = document.getElementById("repeatBtn");

if (playBtn && stopBtn && nextBtn && prevBtn && shuffleBtn && repeatBtn) {

    playBtn.onclick = () => {
        playCurrent();
    };

    stopBtn.onclick = () => {
        audio.pause();
    };

    nextBtn.onclick = () => {
        if (rows.length === 0) return;
        let idx = currentIndex;
        if (idx === -1) idx = 0;
        else idx = (currentIndex + 1) % rows.length;
        loadSong(idx);
        playCurrent();
    };

    prevBtn.onclick = () => {
        if (rows.length === 0) return;
        let idx = currentIndex;
        if (idx === -1) idx = 0;
        else idx = (currentIndex - 1 + rows.length) % rows.length;
        loadSong(idx);
        playCurrent();
    };

    shuffleBtn.onclick = () => {
        if (rows.length === 0) return;
        const idx = Math.floor(Math.random() * rows.length);
        loadSong(idx);
        playCurrent();
    };

    repeatBtn.onclick = () => {
        repeat = !repeat;
    };
}

audio.onended = () => {
    if (repeat) {
        audio.currentTime = 0;
        audio.play();
    } else if (nextBtn) {
        nextBtn.click();
    }
};
</script>


</body>
</html>
