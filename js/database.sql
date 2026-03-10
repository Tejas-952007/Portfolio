-- Portfolio Database Schema Production Ready (v2.0)
CREATE DATABASE IF NOT EXISTS portfolio_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE portfolio_db;

-- 1. Administrator/User Table (For login backend)
CREATE TABLE admin_users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL
);

-- 2. Projects Core Table
CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    short_description VARCHAR(255) NOT NULL,
    problem_statement TEXT,
    solution_approach TEXT,
    tech_stack VARCHAR(255) NOT NULL COMMENT 'Comma separated values like Python, ML, React',
    github_url VARCHAR(255),
    live_demo_url VARCHAR(255),
    thumbnail_path VARCHAR(255),
    category ENUM('AI/ML', 'Data Analysis', 'Web Development', 'Software Engineering', 'Python Scripts') DEFAULT 'Web Development',
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_category (category),
    INDEX idx_featured (is_featured)
);

-- 3. Professional Experience
CREATE TABLE work_experience (
    id INT AUTO_INCREMENT PRIMARY KEY,
    job_title VARCHAR(150) NOT NULL,
    company_name VARCHAR(150) NOT NULL,
    location VARCHAR(150),
    start_date DATE NOT NULL,
    end_date DATE NULL COMMENT 'NULL meaning currently working',
    responsibilities TEXT,
    is_active BOOLEAN GENERATED ALWAYS AS (end_date IS NULL) VIRTUAL
);

-- 4. Inbound Contact Messages
CREATE TABLE contact_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_name VARCHAR(150) NOT NULL,
    sender_email VARCHAR(255) NOT NULL,
    subject VARCHAR(200),
    message_body TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    received_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_unread (is_read)
);

-- 5. Certificates & Achievements
CREATE TABLE certifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    certification_name VARCHAR(200) NOT NULL,
    issuing_organization VARCHAR(150) NOT NULL,
    issue_date DATE,
    credential_url VARCHAR(255),
    image_path VARCHAR(255)
);

-- 6. Initial Data
INSERT INTO projects (title, short_description, tech_stack, github_url, live_demo_url, category, is_featured)
VALUES (
    'Email/SMS Spam Classifier',
    'A machine learning-powered web application that classifies messages as Spam or Ham using a Multinomial Naive Bayes model.',
    'Python, Streamlit, Scikit-Learn, NLTK',
    'https://github.com/Tejas-952007/email-spam-classifier',
    'https://smart-spam-detector.streamlit.app/',
    'AI/ML',
    TRUE
);

INSERT INTO projects (title, short_description, tech_stack, github_url, live_demo_url, category, is_featured)
VALUES (
    'TaskAgent (Voice UI)',
    'An agentic task manager equipped with voice interactions and an analytics dashboard.',
    'Web UI, Chart.js, Voice Recognition',
    'https://github.com/Tejas-952007/TaskAgent-Agentic-Task-Manager-with-Voice-UI',
    'https://tejas-952007.github.io/TaskAgent-Agentic-Task-Manager-with-Voice-UI/',
    'Web Development',
    TRUE
);

INSERT INTO projects (title, short_description, tech_stack, github_url, live_demo_url, category, is_featured)
VALUES (
    'EngiPlanner',
    'A comprehensive planning and scheduling application designed specifically to organize academic workflows.',
    'Software Engineering, Web App',
    'https://github.com/Tejas-952007/EngiPlanner',
    'https://engiplanner.vercel.app',
    'Software Engineering',
    TRUE
);

INSERT INTO projects (title, short_description, tech_stack, github_url, live_demo_url, category, is_featured)
VALUES (
    'Movie Recommender System',
    'A content-based movie recommendation engine that suggests similar movies using TF-IDF vectorization and cosine similarity.',
    'Python, TF-IDF, Cosine Similarity',
    'https://github.com/Tejas-952007/movie-recommender-system',
    'https://mrs-tejas.streamlit.app/',
    'AI/ML',
    TRUE
);