

CREATE DATABASE musicdb
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

USE musicdb;
drop table songs_library;
CREATE TABLE songs_library (
    library_Id INT AUTO_INCREMENT PRIMARY KEY,
    song_Id VARCHAR(100),
    songTitle VARCHAR(255) NOT NULL,
    songDesc TEXT,
    genre VARCHAR(100),
    duration INT,
    musicDirector VARCHAR(255),
    singer VARCHAR(255),
    releaseDate DATE,
    albumName VARCHAR(255),
    songType ENUM('FREE','PREMIUM') DEFAULT 'FREE',
    songStatus ENUM('AVAILABLE','NOTAVAILABLE') DEFAULT 'AVAILABLE'
);
