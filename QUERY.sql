-- TABLE CREATION

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role VARCHAR(50) NOT NULL
CHECK (role IN ('Football Fan', 'Ticket Manager')),
    phone_number VARCHAR(20)
);

CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    fixture VARCHAR(150) NOT NULL,
    tournament_category VARCHAR(100),
    base_ticket_price DECIMAL(10,2) NOT NULL
CHECK (base_ticket_price >= 0),
   match_status VARCHAR(50) NOT NULL
CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    match_id INT NOT NULL,
    seat_number VARCHAR(20),
   payment_status VARCHAR(50)
CHECK (payment_status IN ('Confirmed', 'Pending', 'Refunded', 'Cancelled')),
  total_cost DECIMAL(10,2) NOT NULL CHECK (total_cost >= 0),

    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id)
);


-- INSERT DATA

INSERT INTO Users (user_id, full_name, email, role, phone_number)
VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL),
(5, 'Nafis Ahmed', 'nafis@mail.com', 'Football Fan', '+8801744444444'),
(6, 'Rifat Karim', 'rifat@mail.com', 'Football Fan', '+8801755555555'),
(7, 'Mehedi Hasan', 'mehedi@mail.com', 'Football Fan', '+8801766666666'),
(8, 'Farzana Akter', 'farzana@mail.com', 'Ticket Manager', '+8801777777777'),
(9, 'Rakib Hossain', 'rakib@mail.com', 'Football Fan', NULL);

INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status)
VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80, 'Available'),
(106, 'Arsenal vs Chelsea', 'Premier League', 110, 'Available'),
(107, 'Borussia Dortmund vs Leipzig', 'Bundesliga', 100, 'Available'),
(108, 'Atletico Madrid vs Sevilla', 'La Liga', 95, 'Selling Fast'),
(109, 'Napoli vs Lazio', 'Serie A', 85, 'Available'),
(110, 'Ajax vs PSV Eindhoven', 'Eredivisie', 75, 'Available');

INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost)
VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150),
(502, 1, 102, 'B-04', 'Confirmed', 120),
(503, 2, 101, 'A-13', 'Confirmed', 150),
(504, 2, 101, NULL, NULL, 150),
(505, 3, 102, 'C-20', 'Pending', 120),
(506, 5, 103, 'D-10', 'Confirmed', 130),
(507, 6, 104, 'E-05', 'Confirmed', 90),
(508, 7, 106, 'F-08', 'Pending', 110),
(509, 9, 107, 'G-15', 'Confirmed', 100),
(510, 5, 108, 'H-21', 'Refunded', 95);


-- QUERY 1

SELECT
    match_id,
    fixture,
    base_ticket_price
FROM Matches
WHERE tournament_category = 'Champions League'
  AND match_status = 'Available';

-- QUERY 2

SELECT
    user_id,
    full_name,
    email
FROM Users
WHERE full_name LIKE 'Tanvir%'
   OR full_name ILIKE '%Haque%';

-- QUERY 3

SELECT
    booking_id,
    user_id,
    match_id,
    COALESCE(payment_status, 'Action Required') AS systematic_status
FROM Bookings
WHERE payment_status IS NULL;

-- QUERY 4

SELECT
    b.booking_id,
    u.full_name,
    m.fixture,
    b.total_cost
FROM Bookings b
INNER JOIN Users u
    ON b.user_id = u.user_id
INNER JOIN Matches m
    ON b.match_id = m.match_id;

    -- QUERY 5

SELECT
    u.user_id,
    u.full_name,
    b.booking_id
FROM Users u
LEFT JOIN Bookings b
    ON u.user_id = b.user_id
ORDER BY u.user_id, b.booking_id;

-- QUERY 6

SELECT
    booking_id,
    match_id,
    total_cost
FROM Bookings
WHERE total_cost > (
    SELECT AVG(total_cost)
    FROM Bookings
);

-- QUERY 7

SELECT
    match_id,
    fixture,
    base_ticket_price
FROM Matches
ORDER BY base_ticket_price DESC
LIMIT 2 OFFSET 1;
