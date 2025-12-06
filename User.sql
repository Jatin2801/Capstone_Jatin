CREATE DATABASE user_db;
USE user_db;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    username VARCHAR(50) UNIQUE,
    password VARCHAR(100),
    email VARCHAR(100),
    mobile VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);
truncate table users;

select * from users;

USE user_db;

CREATE TABLE  playlists (
    playlist_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from playlists;

CREATE TABLE playlist_songs (
    playlist_id INT NOT NULL,
    song_id INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (playlist_id, song_id),
    CONSTRAINT fk_playlist_id FOREIGN KEY (playlist_id)
        REFERENCES playlists(playlist_id)
        ON DELETE CASCADE
);
select * from playlist_songs ;
truncate table playlist_songs ;
