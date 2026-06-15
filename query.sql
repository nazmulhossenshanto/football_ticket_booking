CREATE DATABASE football_ticket_booking;
-- create users table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role VARCHAR(20) DEFAULT 'Football Fan',
    phone_number VARCHAR(20)
);

INSERT INTO users
(user_id, full_name, email, role, phone_number)
VALUES
(1,'Tanvir Rahman','tanvir@mail.com','Football Fan','+8801711111111'),
(2,'Asif Haque','asif@mail.com','Football Fan','+8801722222222'),
(3,'Sajjad Rahman','sajjad@mail.com','Ticket Manager','+8801733333333'),
(4,'Jannat Ara','jannat@mail.com','Football Fan',NULL);

-- create matches table 
CREATE TABLE matches (
    match_id INT PRIMARY KEY,
    fixture VARCHAR(150) NOT NULL,
    tournament_category VARCHAR(100) NOT NULL,
    base_ticket_price DECIMAL(10,2) NOT NULL,
    match_status VARCHAR(20) DEFAULT 'Available'
);
INSERT INTO matches (match_id, fixture, tournament_category, match_status)
VALUES
(101,'Real Madrid vs Barcelona','Champions League',150,'Available'),
(102,'Man City vs Liverpool','Premier League',120,'Selling Fast'),
(103,'Bayern Munich vs PSG','Champions League',130,'Available'),
(104,'AC Milan vs Inter Milan','Serie A',90,'Sold Out'),
(105,'Juventus vs Roma','Serie A',80,'Available');

-- create bookings table
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    user_id INT REFERENCES users(user_id) NOT NULL,
    match_id INT REFERENCES matches(match_id) NOT NULL,
    seat_number VARCHAR(20),
    payment_status VARCHAR(20) DEFAULT 'Pending',
    total_cost DECIMAL(10,2)
);

INSERT INTO bookings
(
    booking_id,
    user_id,
    match_id,
    seat_number,
    payment_status,
    total_cost
)
VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150),
(502, 1, 102, 'B-04', 'Confirmed', 120),
(503, 2, 101, 'A-13', 'Confirmed', 150),
(504, 2, 101, NULL, NULL, 150),
(505, 3, 102, 'C-20', 'Pending', 120);

-- query  1
SELECT
    match_id,
    fixture,
    base_ticket_price
FROM matches
WHERE tournament_category = 'Champions League'
  AND match_status = 'Available';

--   query 2
SELECT
    user_id,
    full_name,
    email
FROM users
WHERE full_name ILIKE 'Tanvir%'
   OR full_name ILIKE '%Haque%';

--    query 3
SELECT
    booking_id,
    user_id,
    match_id,
    COALESCE(payment_status, 'Action Required') AS systematic_status
FROM bookings
WHERE payment_status IS NULL;

-- query 4
SELECT
    b.booking_id,
    u.full_name,
    m.fixture,
    b.total_cost
FROM bookings as b
INNER JOIN users as u
    ON b.user_id = u.user_id
INNER JOIN matches as m
    ON b.match_id = m.match_id;

    -- query 5
    SELECT
    u.user_id,
    u.full_name,
    b.booking_id
FROM users as u
LEFT JOIN bookings as b
    ON u.user_id = b.user_id;

    -- query 6
    SELECT
    booking_id,
    match_id,
    total_cost
FROM bookings
WHERE total_cost >
(
    SELECT AVG(total_cost)
    FROM bookings
);

-- query 7
SELECT
    match_id,
    fixture,
    base_ticket_price
FROM matches
ORDER BY base_ticket_price DESC
OFFSET 1
LIMIT 2;