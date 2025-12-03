package com.micro.user.controller;

import com.micro.user.entity.Playlist;
import com.micro.user.service.PlaylistService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import java.util.Map;

@RestController
@RequestMapping("/playlists")
public class PlaylistController {

    private final PlaylistService service;
    private final RestTemplate rest = new RestTemplate();

    @Value("${song.service.url:http://localhost:8083}")
    private String songServiceUrl;

    public PlaylistController(PlaylistService service) {
        this.service = service;
    }

    @PostMapping("/create")
    public ResponseEntity<?> create(@RequestBody Playlist p) {
        return ResponseEntity.ok(service.create(p));
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<?> update(@PathVariable Integer id, @RequestBody Playlist p) {
        var updated = service.update(id, p);
        return updated == null ? ResponseEntity.notFound().build() : ResponseEntity.ok(updated);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<?> delete(@PathVariable Integer id) {
        return service.delete(id) ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<?> listByUser(@PathVariable Integer userId) {
        return ResponseEntity.ok(service.listByUser(userId));
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> get(@PathVariable Integer id) {
        var p = service.get(id);
        return p == null ? ResponseEntity.notFound().build() : ResponseEntity.ok(p);
    }

    @PostMapping("/{playlistId}/add/{songId}")
    public ResponseEntity<?> add(@PathVariable Integer playlistId, @PathVariable Integer songId) {
        Map song = rest.getForObject(songServiceUrl + "/songs/" + songId, Map.class);
        if (song == null) return ResponseEntity.status(404).body("Song not found");

        String status = (String) song.get("songStatus");
        String type = (String) song.get("songType");

        if ("NOTAVAILABLE".equals(status)) return ResponseEntity.badRequest().body("Not available");
        if ("PREMIUM".equals(type)) return ResponseEntity.status(402).body("Premium — must buy");

        return ResponseEntity.ok(service.addSong(playlistId, songId));
    }

    @PostMapping("/{playlistId}/buy-and-add/{songId}")
    public ResponseEntity<?> buyAdd(@PathVariable Integer playlistId, @PathVariable Integer songId) {
        Map song = rest.getForObject(songServiceUrl + "/songs/" + songId, Map.class);
        if (song == null) return ResponseEntity.status(404).body("Song not found");

        return ResponseEntity.ok(service.addSong(playlistId, songId));
    }

    @PostMapping("/{playlistId}/remove/{songId}")
    public ResponseEntity<?> remove(@PathVariable Integer playlistId, @PathVariable Integer songId) {
        return ResponseEntity.ok(service.removeSong(playlistId, songId));
    }
}
