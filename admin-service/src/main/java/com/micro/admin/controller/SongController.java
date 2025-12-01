package com.micro.admin.controller;

import org.springframework.web.bind.annotation.*;
import com.micro.admin.entity.Song;
import com.micro.admin.service.SongService;
import java.util.List;

@RestController
@RequestMapping("/songs")
public class SongController {

    private final SongService service;

    public SongController(SongService service){
        this.service = service;
    }

    @PostMapping("/add")
    public Song add(@RequestBody Song s){
        return service.addSong(s);
    }

    @GetMapping("/available")
    public List<Song> available(){
        return service.availableSongs();
    }

    @GetMapping("/free")
    public List<Song> free(){
        return service.freeSongs();
    }
}
