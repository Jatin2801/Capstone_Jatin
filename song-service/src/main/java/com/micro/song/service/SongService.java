package com.micro.song.service;

import com.micro.song.entity.Song;
import com.micro.song.repository.SongRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SongService {

    private final SongRepository repo;

    public SongService(SongRepository repo) {
        this.repo = repo;
    }

    public Song save(Song s) { return repo.save(s); }

    public List<Song> all() { return repo.findAll(); }

    public Song get(Integer id) { return repo.findById(id).orElse(null); }

    public Song update(Integer id, Song s) {
        return repo.findById(id).map(old -> {
            old.setSongId(s.getSongId());
            old.setSongTitle(s.getSongTitle());
            old.setSongDesc(s.getSongDesc());
            old.setGenre(s.getGenre());
            old.setDuration(s.getDuration());
            old.setMusicDirector(s.getMusicDirector());
            old.setSinger(s.getSinger());
            old.setReleaseDate(s.getReleaseDate());
            old.setAlbumName(s.getAlbumName());
            old.setSongType(s.getSongType());
            old.setSongStatus(s.getSongStatus());
            return repo.save(old);
        }).orElse(null);
    }

    public void delete(Integer id) { repo.deleteById(id); }
}
