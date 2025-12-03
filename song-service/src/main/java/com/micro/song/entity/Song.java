package com.micro.song.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "songs_library")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Song {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer libraryId;
    private String songTitle;
    private String genre;    
    private String musicDirector;
    private String singer;
    private String releaseDate;
    private String albumName;

    @Enumerated(EnumType.STRING)
    private SongType songType;

    @Enumerated(EnumType.STRING)
    private SongStatus songStatus;

    public enum SongType { FREE, PREMIUM }
    public enum SongStatus { AVAILABLE, NOTAVAILABLE }
}
