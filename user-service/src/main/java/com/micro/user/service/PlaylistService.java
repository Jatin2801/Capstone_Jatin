package com.micro.user.service;

import com.micro.user.entity.Playlist;
import com.micro.user.repository.PlaylistRepository;
import org.springframework.stereotype.Service;

@Service
public class PlaylistService {

    private final PlaylistRepository repo;

    public PlaylistService(PlaylistRepository repo) {
        this.repo = repo;
    }

    public Playlist create(Playlist p) { return repo.save(p); }

    public Playlist update(Integer id, Playlist newData) {
        return repo.findById(id).map(p -> {
            p.setName(newData.getName());
            return repo.save(p);
        }).orElse(null);
    }

    public boolean delete(Integer id) {
        return repo.findById(id).map(p -> { repo.delete(p); return true; }).orElse(false);
    }

    public Playlist get(Integer id) { return repo.findById(id).orElse(null); }

    public java.util.List<Playlist> listByUser(Integer userId) { return repo.findByUserId(userId); }

    public Playlist addSong(Integer playlistId, Integer songId) {
        return repo.findById(playlistId).map(p -> {
            if (!p.getSongIds().contains(songId)) {
                p.getSongIds().add(songId);
            }
            return repo.save(p);
        }).orElse(null);
    }

    public Playlist removeSong(Integer playlistId, Integer songId) {
        return repo.findById(playlistId).map(p -> {
            p.getSongIds().removeIf(id -> id.equals(songId));
            return repo.save(p);
        }).orElse(null);
    }
}
