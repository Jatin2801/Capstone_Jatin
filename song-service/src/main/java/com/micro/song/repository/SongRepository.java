package com.micro.song.repository;

import com.micro.song.entity.Song;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SongRepository extends JpaRepository<Song, Integer> {
}
