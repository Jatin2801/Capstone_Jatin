package com.micro.song.repository;

import com.micro.song.entity.Song;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SongRepository extends JpaRepository<Song, Integer> {

   
    List<Song> findBySongTitleContainingIgnoreCaseOrMusicDirectorContainingIgnoreCaseOrSingerContainingIgnoreCase(
            String songTitle,
            String musicDirector,
            String singer
    );
}
