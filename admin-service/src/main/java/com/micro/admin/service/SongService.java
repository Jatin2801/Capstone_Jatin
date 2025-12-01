package com.micro.admin.service;

import com.micro.admin.entity.Song;
import com.micro.admin.repository.SongRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SongService {

    private final SongRepository repo;

    public SongService(SongRepository repo) {
        this.repo = repo;
    }

    public Song addSong(Song s) { return repo.save(s); }

    public List<Song> availableSongs() {
        return repo.findBySongStatus(Song.SongStatus.AVAILABLE);
    }

    public List<Song> freeSongs() {
        return repo.findBySongType(Song.SongType.FREE);
    }
}
