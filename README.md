# Football Ticket Booking System Database

## Project Description
This project is a relational database system for a football ticket booking platform. It manages users, matches, and bookings, and ensures data integrity using primary keys and foreign keys.

## Tables
- Users: Stores user information (fans and ticket managers)
- Matches: Stores match details and pricing
- Bookings: Stores ticket booking records linked with users and matches

## Keys
- Primary Key: Uniquely identifies each record in a table.
- Foreign Key: Links the Bookings table with Users and Matches tables to maintain referential integrity.

## Database Relationship
Users → Bookings ← Matches

Each booking belongs to one user and one match.
