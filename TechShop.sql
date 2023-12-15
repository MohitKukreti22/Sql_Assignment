--Inserting into customers table

INSERT INTO Customers(CustomerID,FirstName,LastName,Email,Phone,Address)VALUES(2,'SUBHAM','NEGI','NEGISUBHAM@GMAIL.COM','9658556472','CHAMBA')
INSERT INTO Customers(CustomerID,FirstName,LastName,Email,Phone,Address)VALUES(3,'SUMIT','RAWAT','SUMITRAWAT@GMAIL.COM','9758719138','HALDWANI')
INSERT INTO Customers(CustomerID,FirstName,LastName,Email,Phone,Address)VALUES(4,'HAPPY','PUNDIR','HAPPYPUNDIR5@GMAIL.COM','9765904369','TEHRI')
INSERT INTO Customers(CustomerID,FirstName,LastName,Email,Phone,Address)VALUES(5,'ROHIT','RANA','ROHITKUKRETI@GMAIL.COM','8867488947','NANITAL')
INSERT INTO Customers(CustomerID,FirstName,LastName,Email,Phone,Address)VALUES(6,'MANOJ','BHANDARI','NAHDIIDAJFJAFJ@GMAIL.COM','6793457439','RAMNAGAR')
-- Inserting into  Products table
INSERT INTO Products (ProductID, ProductName, Description, Price)
VALUES
(1, 'Laptop', 'High-performance laptop', 50000),
(2, 'Mobile', 'Latest smartphone model', 15000),
(3, 'Tablet', '10-inch tablet', 25000),
(4, 'Headphones', 'Wireless headphones', 30000),
(5, 'Camera', 'Digital camera with HD recording', 8000),
(6, 'Smartwatch', 'Fitness and health tracking smartwatch', 1500);

--Inserting  into Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(101, 1, '2023-01-14', 75000),
(102, 2, '2023-02-20', 8000),
(103, 3, '2023-03-10', 15000),
(104, 4, '2023-04-05', 45000);
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES(105, 3, '2023-07-15', 15000),
(106, 4, '2023-11-06', 45000);

-- Inserting data into the OrderDetails table
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
VALUES
(201, 101, 1, 2),
(202, 101, 2, 1),
(203, 102, 1, 1),
(204, 103, 3, 1),
(205, 104, 4, 1),
(206, 105, 5, 1);


-- Inserting data into the Inventory table
INSERT INTO Inventory (InventoryID, ProductID, QuantityInStock, LastStockUpdate)
VALUES
(301, 1, 5, '2023-01-10 08:00:00'),
(302, 2, 10, '2023-02-18 12:30:00'),
(303, 3, 8, '2023-03-05 10:45:00'),
(304, 4, 15, '2023-04-01 09:15:00'),
(305, 5, 6, '2023-04-05 14:20:00'),
(306, 6, 12, '2023-04-05 14:30:00');


--SQL query to retrieve the names and emails of all customers.

SELECT FirstName,LastName,Email FROM Customers;

---SQL query to list all orders with their order dates and corresponding customer names.

SELECT OrderID, FirstName,OrderDate
FROM orders, Customers
WHERE orders.customerid = customers.customerid; 

 --query to update the prices of all electronic gadgets in the "Products" table by increasing them by 10%.

UPDATE Products SET Price = Price + (Price* 10/100);


INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Address)
VALUES (11, 'NewFirstName', 'NewLastName', 'new.email@example.com', 'NewAddress');


ALTER TABLE Products ADD Category VARCHAR(50);

UPDATE Products SET Category = CAST(Description AS VARCHAR(50));

ALTER TABLE Products
DROP COLUMN Description;



DECLARE @OrderIDToDelete INT = 1;

DELETE FROM OrderDetails WHERE OrderID = @OrderIDToDelete;
DELETE FROM Orders WHERE OrderID = @OrderIDToDelete;




-- Insert a new order into the "Orders" table.

DECLARE @CustomerID INT = 7;  
DECLARE @OrderID INT = 109;  
DECLARE @OrderDate DATE = '2023-11-28';  
DECLARE @OrderTotalAmount INT = 4000;  

INSERT INTO Orders (OrderID, CustomerID, OrderDate,TotalAmount)
VALUES (@OrderID, @CustomerID, @OrderDate,@OrderTotalAmount);




----


DECLARE @CustomerIDToUpdate INT = 4;

UPDATE Customers
SET Email = 'new.email@example.com', Address = 'New Address'
WHERE CustomerID = @CustomerIDToUpdate;






UPDATE Orders SET TotalAmount =(SELECT SUM (OrderDetails.Quantity * Products.Price)FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE OrderDetails.OrderID = Orders.OrderID);

-----

DECLARE @CustomerIDToDelete INT = 7;

DELETE FROM OrderDetails WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = @CustomerIDToDelete);
DELETE FROM Orders WHERE CustomerID = @CustomerIDToDelete;

-----
INSERT INTO Products (ProductID, Description, ProductName, Category, Price)
VALUES (11,'CUtting','NewGadget',' electronic gadget', 16000);





-- Add a new column 'Status' to the "Orders" table with a default value of 'Pending'.
ALTER TABLE Orders
ADD Status NVARCHAR(50) DEFAULT 'Pending'; -- Adjust the size of NVARCHAR based on your needs

UPDATE Orders
SET Status = 'Pending'
WHERE Status IS NULL;

-- Update the status of a specific order in the "Orders" table.

DECLARE @OrderIDToUpdate INT = 102;  
DECLARE @NewStatus NVARCHAR(50) = 'Shipped';  

UPDATE Orders SET Status = @NewStatus WHERE OrderID = @OrderIDToUpdate;
select * from Orders;



-- Add a new column NumOrders to the "Customers" table.
ALTER TABLE Customers
ADD NumOrders INT;


-- Update the number of orders placed by each customer in the "Customers" table.


UPDATE Customers
SET NumOrders = (SELECT COUNT(*)FROM Orders WHERE Orders.CustomerID = Customers.CustomerID);





---Aggregate Functions

-----1
SELECT * FROM CUSTOMERS
WHERE CustomerID NOT IN (SELECT CustomerID FROM ORDERS);

-----2

SELECT ProductID,COUNT(*) AS TOTALPRODUCT FROM INVENTORY GROUP BY ProductID;

-----3

SELECT SUM(TotalAmount)AS REVENUE FROM Orders;

------4

DECLARE @P VARCHAR(20)
SET @P='Electronic';

SELECT COUNT(ORDERDETAILS.QUANTITY) AS AVG,PRODUCTS.Category FROM ORDERDETAILS
INNER JOIN PRODUCTS ON ORDERDETAILS.ProductID=PRODUCTS.ProductID WHERE PRODUCTS.Category=@P GROUP BY Products.Category;


----5

SELECT CustomerID,SUM(TOTALAMOUNT) AS REVENUE FROM Orders GROUP BY CustomerID;


--6

SELECT TOP 2 CustomerID,COUNT(CustomerID) AS TOTAL_ORDERS FROM Orders GROUP BY CustomerID ORDER BY COUNT(CustomerID) DESC


---7

SELECT ProductName FROM Products WHERE ProductName IN (SELECT TOP 1 ProductName FROM OrderDetails ORDER BY Quantity DESC);

--8

SELECT TOP 1 C.FIRSTNAME,C.LASTNAME, SUM(O.TOTALAMOUNT) AS TOTAL_SPENDING FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CustomerID=O.CustomerID GROUP BY C.CustomerID,C.FirstName,C.LastName
ORDER BY SUM(O.TotalAmount) DESC;

---9
SELECT C.FIRSTNAME,AVG(O.TOTALAMOUNT) AS Average FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CustomerID=O.CustomerID GROUP BY C.CustomerID,C.FirstName;


---10
SELECT C1.FirstName,COUNT(C2.OrderID)FROM Customers AS C1 INNER JOIN Orders AS C2 ON C1.CustomerID=C2.CustomerID;

--JOINS

---1

SELECT C.CustomerID,Firstname,LastName FROM CUSTOMERS AS C INNER JOIN ORDERS AS O ON C.CustomerID=O.CustomerID INNER JOIN ORDERDETAILS AS O1 ON O.ORDERID=O1.ORDERID
INNER JOIN PRODUCTS AS P ON O1.ProductID=P.ProductID;


--2


SELECT P.ProductID,P.ProductName,O.Quantity*P.PRICE FROM Products AS P
INNER JOIN OrderDetails AS O ON P.ProductID=O.ProductID;

---3


SELECT Customers.CustomerID,Customers.FirstName,Customers.LastName,Customers.Phone From Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerId,Customers.FirstName,Customers.LastName,Customers.Phone;

----4

SELECT Products.Category,Products.ProductName,SUM(OrderDetails.Quantity) AS total_quantity_ordered FROM Products 
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID WHERE Products.Category = 'Electronic' GROUP BY Products.Category,Products.ProductName
ORDER BY total_quantity_ordered DESC;  


----5
SELECT Products.ProductName,Products.Category FROM Products

----6

SELECT Customers.CustomerID,Customers.FirstName,Customers.LastName,
AVG(Orders.TotalAmount) AS average_order_value FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID GROUP BY Customers.CustomerID,Customers.FirstName,Customers.LastName;

----7

SELECT Orders.OrderID,Customers.CustomerID,Customers.FirstName,Customers.LastName,
SUM(Orders.TotalAmount) AS total_revenue FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID GROUP BY Orders.OrderID,Customers.CustomerID,Customers.FirstName,Customers.LastName
ORDER BY total_revenue DESC;

----8

SELECT Products.ProductID,Products.ProductName,Products.Category,COUNT(OrderDetails.OrderId) AS order_count FROM Products
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
WHERE Products.Category = 'Electronic' GROUP BY Products.ProductID,Products.ProductName,Products.Category;


----9

DECLARE @ProductName VARCHAR(20);
SET @ProductName = 'Laptop';
SELECT Customers.CustomerID,Customers.FirstName,Customers.LastName
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.OrderID
JOIN Products ON Orders.OrderID = Products.ProductID
WHERE Products.ProductName = @ProductName;

----10

DECLARE @D1 DATE,@D2 DATE
SET @D1='2023/12/28'
SET @D2='2023/12/31'

SELECT SUM(TOTALAMOUNT) AS 
REVENUE_GENERATED
FROM Orders
WHERE OrderDate BETWEEN @D1 AND @D2