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