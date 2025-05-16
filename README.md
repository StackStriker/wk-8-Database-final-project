# wk-8-Database-final-project
This is a summary of everything I learned at the Database module and classes
# Online Bookstore Database

## Project Description

This project is a **relational database** built using **MySQL**, designed to manage the operations of an online bookstore. It supports:

- Storing book and author information
- Managing customers and their orders
- Tracking which books were purchased in each order
- Calculating total purchase amounts
- Enforcing data integrity with relational constraints

The system uses proper **primary keys**, **foreign keys**, and **SQL constraints** to maintain a robust schema.

## How to Set Up and Run the Project

### Requirements
- MySQL Server installed (or XAMPP/MAMP/WAMP)
- MySQL Workbench **OR** command line access

### Steps to Import and Run:
1. **Download or clone this project**
2. Locate the SQL file: `online_bookstore.sql`
3. Open your **MySQL Workbench** or **command line**
4. Run the SQL script:
   - In MySQL Workbench:  
     - Open the `.sql` file  
     - Click `Run` (⚡) to execute
   - In terminal:
     ```bash
     mysql -u root -p < online_bookstore.sql
     ```
     Enter your MySQL password when prompted.

5. The script will:
   - Create the `OnlineBookstore` database
   - Create all tables with constraints
   - Insert sample data
   - Provide example queries

---

## 📷 Entity Relationship Diagram (ERD)

### 🔗 ERD Link:
[Click here to view ERD](https://dbdiagram.io/d/online-bookstore-erd-6645b0bb96e6e740e6cda0cc)

> ERD created using [dbdiagram.io](https://dbdiagram.io]

## 📂 Tables Overview

| Table         | Description                                |
|---------------|--------------------------------------------|
| `Authors`     | Stores author information                  |
| `Books`       | Stores books with price and author FK      |
| `Customers`   | Customer personal info                     |
| `Orders`      | Tracks when a customer places an order     |
| `OrderDetails`| Junction table for books in an order       |

---

## Example Queries Included
- Get all books by a specific author
- View orders and total prices by customer
- Show books ordered by a specific customer

## Author
STEPHEN MUTUA 
Final Project – MySQL Database

