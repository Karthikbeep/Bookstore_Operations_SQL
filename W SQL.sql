CREATE DATABASE Online_Bookstore;

DROP TABLE IF EXISTS Books;

CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

DROP TABLE IF EXISTS customers;

CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

DROP TABLE IF EXISTS orders;

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT *
FROM Customers

SELECT *
FROM Orders

SELECT *
FROM Books
--Retrieving all books in fiction genre
SELECT *
FROM Books
WHERE genre = 'Fiction'
--books which are published after the year 1950
SELECT *
FROM Books
WHERE published_year > 1950

--listing all the customers from Canada
SELECT *
FROM Customers
WHERE country = 'Canada'

--orders placed November 2023
SELECT *
FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30'

--retrieving the total stock of books available
SELECT 
SUM(stock) AS Total_Stock
FROM Books

--most expensive book
SELECT 
book_id,
title,
genre,
MAX(price) expensive_book
FROM Books
GROUP BY book_id
ORDER BY price DESC LIMIT 1

--customers who ordered more than 1 quantityof a book
SELECT 
order_id,
customer_id,
quantity
FROM Orders
WHERE quantity > 1
ORDER BY quantity ASC

--retrieving all orders where the total amount exceeds $20
SELECT *
FROM Orders
WHERE total_amount > 20

--all genres available in the books
SELECT DISTINCT
genre
FROM Books

--book with lowest stock
SELECT 
MIN(stock)
FROM Books

--total revenue generated from all orders
SELECT 
SUM(total_amount)
FROM Orders

--average price of books in 'Fantasy' genre
SELECT 
AVG(price)
FROM Books
WHERE genre = 'Fantasy'

--customers who have placed atleast two orders
SELECT 
customer_id,
COUNT(order_id)
FROM Orders
GROUP BY customer_id
HAVING COUNT(order_id) >=2

--most frequently ordered book
SELECT 
book_id,
COUNT(order_id)
FROM Orders
GROUP BY book_id
ORDER BY COUNT(book_id) DESC LIMIT 1

--top 3 most expensive books of 'Fantasy' genre
SELECT *
FROM Books
WHERE genre = 'Fantasy'
ORDER BY price DESC LIMIT 3

--total quantity of books sold by each author
SELECT 
b.author,SUM(o.quantity) AS total_quantity_sold
FROM Books b
JOIN Orders o ON b.book_id = o.book_id
GROUP BY author

--cities where customers who spent over $30 are located
SELECT DISTINCT
c.city,o.total_amount
FROM Orders o 
JOIN Customers c ON o.customer_id = c.customer_id
WHERE total_amount > 30

--customer who spent most on orders
SELECT 
customer_id,
SUM(total_amount) as Lifetime_Value
FROM Orders
GROUP BY customer_id
ORDER BY SUM(total_amount) DESC 
LIMIT 1


