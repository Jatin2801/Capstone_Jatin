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
truncate table admin;
select * from songs_library ;