# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version :'3.4.1'
* Rails version : '7.0.8'

# PG and Hostel System (API-Based)

This project implements a RESTful API for managing hostels, rooms, and bookings using Ruby on Rails, Docker, and PostgreSQL.

**Core Features:**

* **User Management:**
    * User registration and login with JWT authentication.
    * Two user roles: Admin and Resident.
    * Admins have full access to manage hostels, rooms, and bookings.
    * Residents can search for rooms and make bookings.

* **Hostel Management:**
    * Create, read, update, and delete hostels.

* **Room Management:**
    * Create, read, update, and delete rooms within a hostel.
    * List rooms for a specific hostel.

* **Booking Management:**
    * Create bookings for rooms.
    * List all bookings (for admins) or personal bookings (for residents).
    * Admins can approve or reject bookings.
    * Residents and admins can cancel bookings.

* **Search and Filters:**
    * Search for rooms by price, capacity, and availability.

**Tech Stack:**

* **Backend:** Ruby on Rails (API mode)
* **Authentication:** JWT (using devise-jwt gem)
* **Database:** PostgreSQL

**Installation & Setup:**

1. **Clone the repository:**
   ```bash
   git clone <repository_url>