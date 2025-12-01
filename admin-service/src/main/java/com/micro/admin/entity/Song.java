package com.micro.admin.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "songs_library")
@Data
public class Song {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer libraryId;

    private Integer songId;
    private String songName;
    private String musicDirector;
    private String singer;
    private LocalDate releaseDate;
    private String albumName;

    @Enumerated(EnumType.STRING)
    private SongType songType;

    @Enumerated(EnumType.STRING)
    private SongStatus songStatus;

    public enum SongType { FREE, PREMIUM }
    public enum SongStatus { AVAILABLE, NOTAVAILABLE }
}
