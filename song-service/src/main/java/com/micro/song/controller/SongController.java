package com.micro.song.controller;

import com.micro.song.entity.Song;
import com.micro.song.service.SongService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/songs")
public class SongController {

    private final SongService service;

    public SongController(SongService service) {
        this.service = service;
    }

    @PostMapping
    public Song save(@RequestBody Song s) { return service.save(s); }

    @GetMapping
    public List<Song> all() { return service.all(); }

    @GetMapping("/{id}")
    public Song get(@PathVariable Integer id) { return service.get(id); }

    @PutMapping("/{id}")
    public Song update(@PathVariable Integer id, @RequestBody Song s) { return service.update(id, s); }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Integer id) { service.delete(id); }
}
