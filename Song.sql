CREATE DATABASE musicdb
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

USE musicdb;
drop table songs_library;

select * from songs_library;
CREATE TABLE songs_library (
    library_id INT AUTO_INCREMENT PRIMARY KEY,
    song_title VARCHAR(100),
    genre VARCHAR(100),
    music_director VARCHAR(100),
    singer VARCHAR(100),
    release_date VARCHAR(100),
    album_name VARCHAR(100),
    song_type VARCHAR(100),
    song_status VARCHAR(100)
);

