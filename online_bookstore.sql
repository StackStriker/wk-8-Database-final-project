-- Online Bookstore Database

DROP DATABASE IF EXISTS OnlineBookstore;
CREATE DATABASE OnlineBookstore;
USE OnlineBookstore;

-- Authors Table
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL
);

-- Books Table
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0),
    AuthorID INT NOT NULL,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    OrderDate DATE NOT NULL DEFAULT CURRENT_DATE,
    CustomerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- OrderDetails Table (for M-M between Orders and Books)
CREATE TABLE OrderDetails (
    OrderID INT NOT NULL,
    BookID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0),
    PRIMARY KEY (OrderID, BookID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Sample Data Inserts

INSERT INTO Authors (Name, Email) VALUES
('J.K. Rowling', 'jkrowling@example.com'),
('George Orwell', 'gorwell@example.com'),
('Isaac Asimov', 'iasimov@example.com');

INSERT INTO Books (Title, ISBN, Price, AuthorID) VALUES
('Harry Potter and the Sorcerer''s Stone', '9780439708180', 19.99, 1),
('1984', '9780451524935', 14.99, 2),
('Foundation', '9780553293357', 16.99, 3),
('Harry Potter and the Chamber of Secrets', '9780439064873', 20.99, 1);

INSERT INTO Customers (Name, Email, Phone) VALUES
('Alice Johnson', 'alicej@example.com', '555-1234'),
('Bob Smith', 'bobsmith@example.com', '555-5678');

INSERT INTO Orders (OrderDate, CustomerID) VALUES
('2025-05-01', 1),
('2025-05-03', 2);

INSERT INTO OrderDetails (OrderID, BookID, Quantity, Price) VALUES
(1, 1, 1, 19.99),
(1, 3, 2, 16.99),
(2, 2, 1, 14.99),
(2, 4, 1, 20.99);

-- Example Queries

-- 1. Get all books by J.K. Rowling
SELECT b.Title, b.ISBN, b.Price
FROM Books b
JOIN Authors a ON b.AuthorID = a.AuthorID
WHERE a.Name = 'J.K. Rowling';

-- 2. Get all orders with customer names and total amounts
SELECT o.OrderID, o.OrderDate, c.Name AS CustomerName,
       SUM(od.Quantity * od.Price) AS TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID, o.OrderDate, c.Name;

-- 3. Get books ordered by a specific customer (Alice Johnson)
SELECT b.Title, od.Quantity, od.Price
FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Books b ON od.BookID = b.BookID
WHERE c.Name = 'Alice Johnson';

-- 4. Get total sales for each book
SELECT b.Title, SUM(od.Quantity * od.Price) AS TotalSales
FROM OrderDetails od
JOIN Books b ON od.BookID = b.BookID
GROUP BY b.Title
ORDER BY TotalSales DESC;
