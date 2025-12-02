CREATE DATABASE admin_db;
USE admin_db;

CREATE TABLE admin (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    admin_name VARCHAR(50),
    username VARCHAR(50) UNIQUE,
    password VARCHAR(100),
    email VARCHAR(100),
    mobile_no VARCHAR(20)
);
select * from admin;
drop table admin;
CREATE TABLE songs_library (
    library_id INT PRIMARY KEY AUTO_INCREMENT,
    song_id INT,
    song_name VARCHAR(100),
    music_director VARCHAR(100),
    singer VARCHAR(100),
    release_date DATE,
    album_name VARCHAR(100),
    song_type ENUM('FREE','PREMIUM'),
    song_status ENUM('AVAILABLE','NOTAVAILABLE')
);
select * from songs_library ;