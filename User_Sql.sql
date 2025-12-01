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
    address1 VARCHAR(100),
    address2 VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zipcode VARCHAR(10),
    country VARCHAR(50),
    status VARCHAR(20)
);
