--Create Tables

CREATE TABLE Books(
       Book_Id SERIAL PRIMARY KEY,
	   Title  VARCHAR(100),
	   Author VARCHAR(100),
	   Genre VARCHAR(50),
	   Published_Year INT,
	   Price NUMERIC(10,2),
	   Stock INT
);

CREATE TABLE Customers(
       Customer_ID SERIAL PRIMARY KEY,
	   Name VARCHAR(100),
	   Email VARCHAR(100),
	   Phone VARCHAR(15),
	   City VARCHAR(50),
	   Country VARCHAR(150)
);

CREATE TABLE Orders(
       Order_Id SERIAL PRIMARY KEY,
	   Customer_Id INT REFERENCE Customers(Customer_ID),
	   Book_Id INT REFERENCE Books(Book_Id),
	   Order_Date DATE,
	   Quantity INT,
	   Total_Amount NUMERIC(10,2)
);

SELECT*FROM Books;
SELECT*FROM Customers;
SELECT*FROM Orders;

ALTER TABLE Customers
ALTER COLUMN Email TYPE VARCHAR(100);

--Import Data into Customers Table
COPY Customers(Customer_ID,Name,Email,Phone,City,Country)
FROM 'C:\Program Files\PostgreSQL\18\data\Customers.csv'
DELIMITER ','
CSV HEADER;

-- 1) Retrieve all books in the "Fiction" genre :
SELECT*FROM Books 
WHERE genre = 'Fiction';

-- 2) Find books published after the year 1950 :
SELECT*FROM Books 
WHERE published_year > 1950;

-- 3) List all customers from the Canada :
SELECT*FROM Customers
WHERE Country = 'Canada';

-- 4) Show Order placed in November 2023 :
SELECT*FROM Orders
Where Order_date BETWEEN '01-11-2023' AND '30-11-2023';

-- 5) Retrieve the total stock of books available :
SELECT SUM(Stock) as Total_Stock FROM Books;

-- 6) Find the details of the most expensive book :
SELECT*FROM Books 
ORDER BY Price DESC LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book : 
SELECT*FROM Orders
WHERE quantity>1;

/*SELECT c.name,o.quantity 
FROM Customers c 
JOIN Orders o
ON quantity >1 ;
*/

-- 8) Retrieve all orders where the total amount exceeds $20 :
SELECT*FROM Orders
WHERE total_amount > 20;

-- 9) List all genres available in the Books table :
SELECT DISTINCT  genre FROM Books ;

-- 10) Find the book with the lowest stock :
SELECT*FROM Books
ORDER BY Stock
LIMIT 1;

-- 11) Calculate the total revenue generated from all orders :
SELECT SUM(total_amount) as Total_Revenue 
FROM Orders;


SELECT*FROM Books;
SELECT*FROM Customers;
SELECT*FROM Orders;

-- Advance Questions :
-- 1) Retrieve the total number of books sold for each genre :
SELECT b.Genre, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b
ON o.Book_Id = b.Book_Id 
GROUP BY b.Genre;

-- 2) Find the average price of books in the "Fantasy" genre :
SELECT AVG(Price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';

-- 3) List Customers who have placed at least 2 Orders :
SELECT o.Customer_Id, c.Name ,COUNT(o.Order_Id) AS Order_Count
FROM Orders o
JOIN Customers c
ON o.Customer_Id=c.Customer_Id
GROUP BY o.Customer_Id ,c.Name
Having COUNT(Order_Id) >=2  ORDER BY Customer_Id;

-- 4) Find the most frequently Ordered Book :
SELECT o.Book_Id ,b.Title, COUNT(o.Order_Id) AS Order_Count
FROM Orders o
JOIN Books b
ON o.Book_Id=b.Book_Id
GROUP BY o.Book_Id ,b.Title
ORDER BY Order_Count DESC LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT*FROM Books 
WHERE Genre='Fantasy'
ORDER BY Price DESC LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author :
SELECT b.Author, SUM(o.Quantity) AS Total_Books_Sold
FROM Books b
JOIN Orders o
ON b.Book_Id = o.Book_Id
GROUP BY Author ;

-- 7) List the cities where Customers who spent over $30 are located : 
SELECT DISTINCT c.City , Total_Amount
FROM OrderS o
JOIN Customers c 
ON o.Customer_Id=c.Customer_Id
WHERE o.Total_Amount > 30
ORDER BY Total_Amount DESC;

-- 8)Find the Customer who spent the most on Orders :
SELECT c.Customer_Id ,c.Name , SUM(o.Total_Amount) AS Total_Spent
FROM Orders o
JOIN Customers c ON o.Customer_Id=c.Customer_Id
GROUP BY c.Customer_Id , c.Name
ORDER BY Total_Spent DESC ;

-- 9)Calculate the Stock remaining after fulfilling all Orders :
SELECT b.Book_Id,b.Title,b.Stock,COALESCE(SUM(o.quantity),0) AS Order_Quantity,
b.Stock - COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM Books b
LEFT JOIN Orders o ON b.Book_Id = o.Book_Id
GROUP BY b.Book_Id
ORDER BY b.Book_Id;



