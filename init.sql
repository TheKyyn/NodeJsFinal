CREATE DATABASE IF NOT EXISTS NodeJsDB;
USE NodeJsDB;

CREATE TABLE IF NOT EXISTS users (
                                     id INT AUTO_INCREMENT PRIMARY KEY,
                                     username VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    quota_used BIGINT DEFAULT 0
    );

CREATE TABLE IF NOT EXISTS files (
                                     id INT AUTO_INCREMENT PRIMARY KEY,
                                     user_id INT,
                                     filename VARCHAR(255),
    filepath VARCHAR(255),
    filesize BIGINT,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
    );

CREATE TABLE IF NOT EXISTS shared_links (
                                            id INT AUTO_INCREMENT PRIMARY KEY,
                                            file_id INT,
                                            token VARCHAR(255) UNIQUE,
    expires_at TIMESTAMP,
    FOREIGN KEY (file_id) REFERENCES files(id)
    );