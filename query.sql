CREATE DATABASE football_ticket_booking;
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role VARCHAR(20) DEFAULT 'Football Fan',
    phone_number VARCHAR(20)
);