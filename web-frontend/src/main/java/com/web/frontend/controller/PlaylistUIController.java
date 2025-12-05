package com.web.frontend.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.ui.Model;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.*;

@Controller
@RequestMapping("/playlists")
public class PlaylistUIController {

    private final RestTemplate rest = new RestTemplate();

    @Value("${USER_SERVICE_URL}")
    private String userService;

    @Value("${SONG_SERVICE_URL}")
    private String songService;

    @GetMapping("/user/{userId}")
    public String list(@PathVariable Integer userId, Model model) {
        List playlists = rest.getForObject(userService + "/playlists/user/" + userId, List.class);
        model.addAttribute("playlists", playlists);
        model.addAttribute("userId", userId);
        return "user-playlists";
    }

    @PostMapping("/create")
    public String create(@RequestParam String name, @RequestParam Integer userId) {
        Map body = Map.of("name", name, "userId", userId);
        rest.postForObject(userService + "/playlists/create", body, Map.class);
        return "redirect:/playlists/user/" + userId;
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id, @RequestParam Integer userId) {
        rest.delete(userService + "/playlists/delete/" + id);
        return "redirect:/playlists/user/" + userId;
    }

    @GetMapping("/view/{id}")
    public String view(@PathVariable Integer id,
                       @RequestParam Integer userId,
                       @RequestParam(required = false) String songName,
                       @RequestParam(required = false) String musicDirector,
                       @RequestParam(required = false) String album,
                       Model model) {

        Map playlist = rest.getForObject(userService + "/playlists/" + id, Map.class);
        model.addAttribute("playlist", playlist);
        model.addAttribute("userId", userId);

        List songsInPlaylist = buildSongsInPlaylist(playlist);

        // ---------- FILTERING LOGIC ----------
        songsInPlaylist = (List) songsInPlaylist.stream()
                .filter(s -> {
                    if (!(s instanceof Map)) return true;
                    Map map = (Map)s;

                    boolean match = true;

                    if(songName != null && !songName.isBlank())
                        match &= map.get("songTitle") != null &&
                                 map.get("songTitle").toString().toLowerCase()
                                 .contains(songName.toLowerCase());

                    if(musicDirector != null && !musicDirector.isBlank())
                        match &= map.get("musicDirector") != null &&
                                 map.get("musicDirector").toString().toLowerCase()
                                 .contains(musicDirector.toLowerCase());

                    if(album != null && !album.isBlank())
                        match &= map.get("albumName") != null &&
                                 map.get("albumName").toString().toLowerCase()
                                 .contains(album.toLowerCase());

                    return match;
                }).toList();

        model.addAttribute("songsInPlaylist", songsInPlaylist);

        model.addAttribute("songName", songName);
        model.addAttribute("musicDirector", musicDirector);
        model.addAttribute("album", album);

        return "playlist-details";
    }


    @GetMapping("/add/{playlistId}")
    public String addSongsPage(@PathVariable Integer playlistId,
                               @RequestParam Integer userId,
                               @RequestParam(required = false) String keyword,
                               Model model) {

        Map playlist = rest.getForObject(userService + "/playlists/" + playlistId, Map.class);
        model.addAttribute("playlist", playlist);
        model.addAttribute("userId", userId);

        // songs currently in this playlist
        List songsInPlaylist = buildSongsInPlaylist(playlist);
        model.addAttribute("songsInPlaylist", songsInPlaylist);

        // build URL for song search / all songs
        String url;
        if (keyword != null && !keyword.trim().isEmpty()) {
            url = UriComponentsBuilder
                    .fromHttpUrl(songService + "/songs/search")
                    .queryParam("keyword", keyword.trim())
                    .toUriString();
            model.addAttribute("keyword", keyword);
        } else {
            url = songService + "/songs";
        }

        List allSongs = rest.getForObject(url, List.class);

        // ---- mark songs that are already in playlist ----
        java.util.Set<Integer> existingIds = new java.util.HashSet<>();
        for (Object o : songsInPlaylist) {
            java.util.Map m = (java.util.Map) o;
            Object idObj = m.get("libraryId");
            if (idObj != null) {
                existingIds.add(Integer.valueOf(idObj.toString()));
            }
        }

        for (Object o : allSongs) {
            java.util.Map m = (java.util.Map) o;
            Object idObj = m.get("libraryId");
            boolean already = false;
            if (idObj != null) {
                already = existingIds.contains(Integer.valueOf(idObj.toString()));
            }
            m.put("alreadyInPlaylist", already);
        }

        model.addAttribute("allSongs", allSongs);

        return "addPlaylist";
    }


    @PostMapping("/add/{playlistId}/{songId}")
    public String add(@PathVariable Integer playlistId,
                      @PathVariable Integer songId,
                      @RequestParam Integer userId) {
        try {
            rest.postForObject(userService + "/playlists/" + playlistId + "/add/" + songId, null, Map.class);
        } catch (Exception ignored) {
        }
        return "redirect:/playlists/view/" + playlistId + "?userId=" + userId;
    }

    @PostMapping("/buy-and-add/{playlistId}/{songId}")
    public String buyAdd(@PathVariable Integer playlistId,
                         @PathVariable Integer songId,
                         @RequestParam Integer userId) {
        rest.postForObject(userService + "/playlists/" + playlistId + "/buy-and-add/" + songId, null, Map.class);
        return "redirect:/playlists/view/" + playlistId + "?userId=" + userId;
    }

    @GetMapping("/remove/{playlistId}/{songId}")
    public String remove(@PathVariable Integer playlistId,
                         @PathVariable Integer songId,
                         @RequestParam Integer userId) {
        rest.postForObject(userService + "/playlists/" + playlistId + "/remove/" + songId, null, Map.class);
        return "redirect:/playlists/view/" + playlistId + "?userId=" + userId;
    }

    // helper to fetch songs in a playlist from song-service
    private List buildSongsInPlaylist(Map playlist) {
        List<Integer> ids = (List<Integer>) playlist.get("songIds");
        List songsInPlaylist = new ArrayList();
        if (ids != null) {
            ids.forEach(sid -> {
                try {
                    songsInPlaylist.add(rest.getForObject(songService + "/songs/" + sid, Map.class));
                } catch (Exception ignored) {
                }
            });
        }
        return songsInPlaylist;
    }
}
