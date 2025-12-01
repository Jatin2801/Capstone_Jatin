package com.micro.admin.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.micro.admin.entity.Song;
import java.util.List;

public interface SongRepository extends JpaRepository<Song, Integer> {
    List<Song> findBySongStatus(Song.SongStatus status);
    List<Song> findBySongType(Song.SongType type);
}
