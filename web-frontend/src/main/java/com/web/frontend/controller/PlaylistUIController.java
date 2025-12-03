package com.web.frontend.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.ui.Model;
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
    public String view(@PathVariable Integer id, @RequestParam Integer userId, Model model) {
        Map playlist = rest.getForObject(userService + "/playlists/" + id, Map.class);
        model.addAttribute("playlist", playlist);
        model.addAttribute("userId", userId);

        List<Integer> ids = (List<Integer>) playlist.get("songIds");
        List songsInPlaylist = new ArrayList();
        if (ids != null) {
            ids.forEach(sid -> {
                try {
                    songsInPlaylist.add(rest.getForObject(songService + "/songs/" + sid, Map.class));
                } catch (Exception ignored) {}
            });
        }
        model.addAttribute("songsInPlaylist", songsInPlaylist);

        List allSongs = rest.getForObject(songService + "/songs", List.class);
        model.addAttribute("allSongs", allSongs);

        return "playlist-details";
    }

    @PostMapping("/add/{playlistId}/{songId}")
    public String add(@PathVariable Integer playlistId, @PathVariable Integer songId, @RequestParam Integer userId) {
        try { rest.postForObject(userService + "/playlists/" + playlistId + "/add/" + songId, null, Map.class); }
        catch (Exception ignored) {}
        return "redirect:/playlists/view/" + playlistId + "?userId=" + userId;
    }

    @PostMapping("/buy-and-add/{playlistId}/{songId}")
    public String buyAdd(@PathVariable Integer playlistId, @PathVariable Integer songId, @RequestParam Integer userId) {
        rest.postForObject(userService + "/playlists/" + playlistId + "/buy-and-add/" + songId, null, Map.class);
        return "redirect:/playlists/view/" + playlistId + "?userId=" + userId;
    }

    @GetMapping("/remove/{playlistId}/{songId}")
    public String remove(@PathVariable Integer playlistId, @PathVariable Integer songId, @RequestParam Integer userId) {
        rest.postForObject(userService + "/playlists/" + playlistId + "/remove/" + songId, null, Map.class);
        return "redirect:/playlists/view/" + playlistId + "?userId=" + userId;
    }
}
