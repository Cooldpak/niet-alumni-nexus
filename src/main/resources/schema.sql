CREATE DATABASE IF NOT EXISTS niet_nexus_db;
USE niet_nexus_db;

CREATE TABLE Users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('STUDENT', 'ALUMNI', 'ADMIN') NOT NULL,
    status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Profiles (
    user_id BIGINT PRIMARY KEY,
    department VARCHAR(100),
    graduation_year INT,
    current_industry VARCHAR(100),
    company VARCHAR(150),
    job_title VARCHAR(150),
    skills TEXT,
    willingness_to_refer BOOLEAN DEFAULT FALSE,
    mentorship_points INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

CREATE TABLE Connections (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    requester_id BIGINT NOT NULL,
    receiver_id BIGINT NOT NULL,
    status ENUM('REQUESTED', 'ACCEPTED', 'REJECTED') DEFAULT 'REQUESTED',
    message TEXT,
    connection_type ENUM('MENTORSHIP', 'B2B_NETWORKING') DEFAULT 'MENTORSHIP',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (requester_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES Users(id) ON DELETE CASCADE
);

CREATE TABLE Job_Posts (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    alumni_id BIGINT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    company VARCHAR(150),
    location VARCHAR(150),
    is_referral_available BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (alumni_id) REFERENCES Users(id) ON DELETE CASCADE
);

CREATE TABLE Messages (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sender_id BIGINT NOT NULL,
    receiver_id BIGINT NOT NULL,
    content TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (sender_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES Users(id) ON DELETE CASCADE
);

CREATE TABLE Resources (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    uploader_id BIGINT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    file_url VARCHAR(255) NOT NULL,
    type ENUM('INTERVIEW_EXP', 'ROADMAP', 'ALUMNI_PERK') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (uploader_id) REFERENCES Users(id) ON DELETE CASCADE
);
