create database Courier Management;

use Courier Management;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,Name VARCHAR(255),Email VARCHAR(255) UNIQUE,actNumber VARCHAR(20),Address TEXT);
CREATE TABLE CourierServices (ServiceID INT PRIMARY KEY,ServiceName VARCHAR(100),cost DECIMAL(8, 2));
CREATE TABLE Couriers (
    CourierID INT PRIMARY KEY,SenderID INT,ReceiverID INT,Weight DECIMAL(5, 2),Status VARCHAR(50),TrackingNumber VARCHAR(20) UNIQUE,veryDate DATE,
    FOREIGN KEY (SenderID) REFERENCES Customers(CustomerID),                                                                                                                                                                                         
    FOREIGN KEY (ReceiverID) REFERENCES Customers(CustomerID));

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,CustomerID INT,CourierID INT,ServiceID INT,PaymentID INT, OrderDate DATE);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,Name VARCHAR(255),Email VARCHAR(255) UNIQUE,ContactNumber VARCHAR(20),Role VARCHAR(50),Salary DECIMAL(10, 2)
);
CREATE TABLE Location (
    LocationID INT PRIMARY KEY,LocationName VARCHAR(100),Address TEXT);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,CourierID INT,LocationID INT,Amount DECIMAL(10, 2),PaymentDate DATE);
    
INSERT INTO Customers (CustomerID, Name, Email, actNumber, Address)
VALUES
    (101, 'John', 'johndoe@example.com', '4567890', '123 Main Street'),
    (102, 'Jane ', 'janesmith@example.com', '7654321', '456 Oak Avenue'),
    (103, 'Alice ', 'alicejohnson@example.com', '2334455', '789 Elm Street'),
    (104, 'Bob ', 'bobwilliams@example.com', '550998877', '321 Pine Road'),
    (105, 'Emily', 'emilydavis@example.com', '7776655', '567 Cedar Lane');
    
INSERT INTO Couriers (CourierID, SenderID, ReceiverID, Weight, Status, TrackingNumber, veryDate) 
VALUES
    (201, 101, 102, 3.25, 'In Transit', 'TN12345', '2023-11-05'),
    (202, 102, 103, 2.80, 'Delivered', 'TN67890', '2023-10-22'),
    (203, 103, 104, 5.10, 'Pending', 'TN54321', '2023-11-15'),
    (204, 104, 105, 1.75, 'In Warehouse', 'TN24680', '2023-11-28'),
    (205, 105, 101, 4.60, 'In Transit', 'TN13579', '2023-11-10');
    
INSERT INTO CourierServices (ServiceID, ServiceName, Cost)
VALUES
    (401, 'Next Day ', 50.99),
    (402, 'Economy y', 29.99),
    (403, 'International', 50.99),
    (404, 'Same Day Delivery', 100.99),
     (405, 'Same Day Delivery', 95.99);
INSERT INTO Orders (OrderID, CustomerID, CourierID, ServiceID, PaymentID, OrderDate)
VALUES
    (301, 101, 201, 401, 501, '2023-11-01'),
    (302, 102, 202, 402, 502, '2023-11-03'),
    (303, 103, 203, 403, 503, '2023-11-05'),
    (304, 104, 204, 404, 504, '2023-11-07'),
    (305, 105, 205, 405, 505, '2023-11-09');
    
INSERT INTO Employee (EmployeeID, Name, Email, ContactNumber, Role, Salary)
VALUES
    (501, 'Michael ', 'michael@example.com', '334455', 'Manager', 50000.00),
    (502, 'Sarah', 'sarah@example.com', '445566', 'Supervisor', 40000.00),
    (503, 'David ', 'david@example.com', '4556677', 'Operator', 30000.00),
    (504, 'Emma ', 'emma@example.com', '5667788', 'Delivery Staff', 25000.00),
    (505, 'Ryan', 'ryan@example.com', '6778899', 'Warehouse Staff', 22000.00);
    
INSERT INTO Location (LocationID, LocationName, Address)
VALUES
    (601, 'Main Office', '789 Business Road, City, Country'),
    (602, 'Branch Office', '456 Commercial Street, Town, Country'),
    (603, 'Warehouse', '123 Logistics Avenue, Suburb, Country'),
    (604, 'Distribution Center', '321 Supply Lane, County, Country'),
    (605, 'Regional Office', '567 Operations Street, Region, Country');
    
INSERT INTO Payment (PaymentID, CourierID, LocationID, Amount, PaymentDate)
VALUES
    (701, 201, 601, 100.00, '2023-11-05'),
    (702, 202, 602, 150.00, '2023-11-07'),
    (703, 203, 603, 200.00, '2023-11-09'),
    (704, 204, 604, 75.00, '2023-11-11'),
    (705, 205, 605, 120.00, '2023-11-13');
    
  -- TASK 1  
  
-- 1. list all customers
SELECT * FROM Customers;

-- 2.List all orders for a specific customer:
SELECT * FROM Orders WHERE Customerid = 102;

-- 3.List all couriers:
SELECT * FROM Couriers;

-- 4.List all packages for a specific order:
SELECT * FROM Parcels WHERE OrderID = 303;

-- 5. List all deliveries for a specific courier:
SELECT * FROM Orders WHERE CourierID = 202;

-- 6. List all undelivered packages:
SELECT * FROM Couriers WHERE Status != 'Delivered';

-- 7. List all packages that are scheduled for delivery today
SELECT * FROM Couriers WHERE veryDate = CURDATE();

-- 8.List all packages with a specific status:
SELECT * FROM Couriers WHERE Status = 'In transit';

-- 9. Calculate the total number of packages for each courier
SELECT CourierID, COUNT(*) AS TotalPackages
FROM Couriers
GROUP BY CourierID;

-- 10.Find the average delivery time for each courier:

update Couriers  set Status='Delivered' where CourierID=204;
update Couriers  set Status='Delivered' where CourierID=205;

SELECT AVG(DATEDIFF(c.veryDate, o.OrderDate)) AS AvgDeliveryTime
FROM Couriers c  join Orders o On c.CourierID = o.CourierID Where c.Status='Delivered';

-- 11. List all packages with a specific weight range:
SELECT * FROM couriers WHERE Weight BETWEEN 2.00 AND 5.00;

-- 12.Retrieve employees whose names contain 'John':
SELECT * FROM Employee WHERE Name LIKE '%John%';

-- 13. Retrieve all courier records with payments greater than $50:
SELECT * FROM Payment WHERE Amount > 50.00;

-- TASK 2

-- 14. Find the total number of couriers handled by each employee:
SELECT e.EmployeeID, e.Name, COUNT(c.CourierID) AS TotalCouriersHandled
FROM Employee e
LEFT JOIN Couriers c ON e.EmployeeID = c.EmployeeID
GROUP BY e.EmployeeID,name;

-- 15. Calculate the total revenue generated by each location
SELECT p.LocationID, l.LocationName, SUM(p.Amount) AS TotalRevenue
FROM Payment p
INNER JOIN Location l ON p.LocationID = l.LocationID
GROUP BY p.LocationID;

-- 16. Find the total number of couriers delivered to each location:

SELECT c.ReceiverID AS LocationID, COUNT(c.CourierID) AS TotalCouriersDelivered
FROM Couriers c
GROUP BY c.ReceiverID;

-- 17. Find the courier with the highest average delivery time:

SELECT c.CourierID ,DATEDIFF(c.veryDate, o.OrderDate) AS AvgDeliveryTime
FROM Couriers c  
join Orders o On c.CourierID = o.CourierID Where c.Status='Delivered'
order by AvgDeliveryTime
desc limit 1;

-- 18. Find Locations with Total Payments Less Than a Certain Amount:
SELECT LocationID, Amount AS TotalAmount
FROM Payment
GROUP BY LocationID
HAVING TotalAmount < 5000;

-- 19. Calculate Total Payments per Location:
SELECT LocationID, SUM(Amount) AS TotalAmount
FROM Payment
GROUP BY LocationID;

-- 20. Retrieve couriers who have received payments totaling more than $1000 in a specific location (LocationID = X):
SELECT CourierID, SUM(Amount) AS TotalPayments
FROM Payment
WHERE LocationID = 605
GROUP BY CourierID
HAVING TotalPayments > 1000;

-- 21.Retrieve couriers who have received payments totaling more than $1000 after a certain date (PaymentDate > 'YYYY-MM-DD'):
SELECT CourierID, SUM(Amount) AS TotalPayments
FROM Payment
WHERE PaymentDate > '2023-11-09'
GROUP BY CourierID
HAVING TotalPayments > 1000;

-- 22. Retrieve locations where the total amount received is more than $5000 before a certain date (PaymentDate > 'YYYY-MM-DD'):

UPDATE Payment SET Amount = 5500.00 WHERE Amount = 120.00;
UPDATE Payment SET Amount = 6000.00 WHERE Amount = 75.00;
SELECT LocationID, SUM(Amount) AS TotalAmount
FROM Payment
WHERE PaymentDate > '2023-11-09'
GROUP BY LocationID
HAVING SUM(Amount) > 5000;
select * from payment;


-- TASK 3

-- 23 Retrieve Payments with Courier Information (Inner Join):
SELECT p.*, c.*
FROM Payment p
INNER JOIN Couriers c ON p.CourierID = c.CourierID;
 
 -- 24. Retrieve Payments with Location Information

SELECT p.*, l.*
FROM Payment p
INNER JOIN Location l ON p.LocationID = l.LocationID;
 
-- 25. Retrieve Payments with Courier and Location Information 

SELECT p.*, c.*, l.*
FROM Payment p
INNER JOIN Couriers c ON p.CourierID = c.CourierID
INNER JOIN Location l ON p.LocationID = l.LocationID;

-- 26. List all payments with courier details 
SELECT p.*, c.*
FROM Payment p
LEFT JOIN Couriers c ON p.CourierID = c.CourierID;

-- 27. Total payments received for each courier 

SELECT c.CourierID, SUM(p.Amount) AS TotalPaymentsReceived
FROM Couriers c
INNER JOIN Payment p ON c.CourierID = p.CourierID
GROUP BY c.CourierID;

-- 28. List payments made on a specific date 

SELECT p.*, c.*, l.*
FROM Payment p
INNER JOIN Couriers c ON p.CourierID = c.CourierID
INNER JOIN Location l ON p.LocationID = l.LocationID
WHERE p.PaymentDate = '2023-11-09';

-- 29. Get Courier Information for Each Payment (Inner Join):

SELECT p.*, c.*
FROM Payment p
INNER JOIN Couriers c ON p.CourierID = c.CourierID;

-- 30. Get Payment Details with Location (Inner Join):

SELECT p.*, l.*
FROM Payment p
INNER JOIN Location l ON p.LocationID = l.LocationID;

-- 31. Calculating Total Payments for Each Courier (Inner Join with Group By):

SELECT c.CourierID, SUM(p.Amount) AS TotalPayments
FROM Couriers c
LEFT JOIN Payment p ON c.CourierID = p.CourierID
GROUP BY c.CourierID;

-- 32. List Payments Within a Date Range (Inner Join with Where Clause):

SELECT p.*, c.*, l.*
FROM Payment p
INNER JOIN Couriers c ON p.CourierID = c.CourierID
INNER JOIN Location l ON p.LocationID = l.LocationID
WHERE p.PaymentDate BETWEEN '2023-11-07' AND '2023-11-11';

-- 33. Retrieve a list of all users and their corresponding courier records:
SELECT * FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
UNION 
SELECT * FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.CustomerID IS NULL;

-- 34. Retrieve a list of all couriers and their corresponding services:
SELECT * FROM Couriers
LEFT JOIN Orders ON Couriers.CourierID = Orders.CourierID
UNION
SELECT * FROM Couriers
RIGHT JOIN Orders ON Couriers.CourierID = Orders.CourierID
WHERE Couriers.CourierID IS NULL;


-- 35. Retrieve a list of all employees and their corresponding payments:
SELECT * FROM Employee
LEFT JOIN Payment ON Employee.EmployeeID = Payment.CourierID
UNION 
SELECT * FROM Employee
RIGHT JOIN Payment ON Employee.EmployeeID = Payment.CourierID;


-- 36. List all users and all courier services, showing all possible combinations (Cross Join):

SELECT * FROM Customers
CROSS JOIN Couriers;

-- 37 List all employees and all locations, showing all possible combinations (Cross Join):
SELECT * FROM Employee
CROSS JOIN Location;

-- 38 Retrieve a list of couriers and their corresponding sender information (if available)

SELECT c.*, s.*
FROM Couriers c
LEFT JOIN Customers s ON c.SenderID = s.CustomerID;

-- 39. Retrieve a list of couriers and their corresponding receiver information (if available):
SELECT c.*, r.*
FROM Couriers c
LEFT JOIN Customers r ON c.ReceiverID = r.CustomerID;

-- 40. Retrieve a list of couriers along with the courier service details (if available):
SELECT c.*, o.*
FROM Couriers c
left JOIN Orders o ON c.CourierID = o.CourierID;

insert into Customers values (100, 'swathi', 'swa@gmail', 458962,' cbe');
select * from orders;
select * from customers;

-- 41. Retrieve a list of employees and the number of couriers assigned to each employee:

select e.employeeid, e.name, count(c.courierid) as totalcouriers 
from employee e 
left join couriers c on e.employeeid = c.employeeid 
group by e.employeeid, e.name;


-- 42. Retrieve a list of locations and the total payment amount received at each location:
SELECT l.LocationID, l.LocationName, SUM(p.Amount) AS TotalAmountReceived
FROM Location l
INNER JOIN Payment p ON l.LocationID = p.LocationID
GROUP BY l.LocationID, l.LocationName;

-- 43. Retrieve all couriers sent by the same sender (based on SenderName).

alter table Couriers add SenderName varchar(50);
update Couriers set SenderName = 'annnu' where CourierID=201;
update Couriers set SenderName = 'priya' where CourierID=202;
update Couriers set SenderName = 'arun' where CourierID=203;
update Couriers set SenderName = 'arun' where CourierID=204;
update Couriers set SenderName = 'sriji' where CourierID=205;
select * from couriers;

SELECT c1.CourierID, c2.SenderName
FROM Couriers c1
JOIN Couriers c2 ON c1.SenderName = c2.SenderName AND c1.CourierID <> c2.CourierID;

-- 44. List all employees who share the same role.
select * from employee;
update Employee set Role = 'Operator' where Name='Ryan';

SELECT e1.*
FROM Employee e1
JOIN Employee e2 ON e1.Role = e2.Role AND e1.EmployeeID <> e2.EmployeeID;

-- 45. Retrieve all payments made for couriers sent from the same location.

select * from location;
select * from payment;

select p1.* from Payment p1 join Payment p2 on p1.LocationID = p2.LocationID AND p1.PaymentID <> p2.PaymentID;

-- 46. Retrieve all couriers sent from the same location (based on SenderAddress).
select c1.* from  Couriers c1 join Couriers c2 on c1.SenderAdd = c2.SenderAdd AND c1.CourierID != c2.CourierID;

-- 47. List employees and the number of couriers they have delivered:

select e.employeeid, e.name, count(c.courierid) as totalcouriers from employee e 
left join couriers c on e.employeeid = c.employeeid where c.status = 'delivered' group by e.employeeid, e.name;


-- 48. . Find couriers that were paid an amount greater than the cost of their respective courier services
update Couriers set CostOfService = 200 where CourierID =202;
SELECT c.*, p.*
FROM Couriers c
INNER JOIN Payment p ON c.CourierID = p.CourierID
WHERE p.Amount > c.CostOfService;

-- TASK 4
-- 49. Find couriers that have a weight greater than the average weight of all couriers (Subquery):

select * from Couriers;
select * from Couriers where Weight > (select avg(Weight) from Couriers);

-- 50 Find the names of all employees who have a salary greater than the average salary (Subquery):

select * from Employee where salary > (select avg(salary) from employee);

-- 51 Find the total cost of all courier services where the cost is less than the maximum cost (Subquery):

alter table Couriers add CostOfService decimal(10,2);
update Couriers set CostOfService = 50.00 where CourierID=201;
update Couriers set CostOfService = 200.00 where CourierID=202;
update Couriers set CostOfService = 45.00 where CourierID=203;
update Couriers set CostOfService = 75.00 where CourierID=204;
update Couriers set CostOfService = 37.00 where CourierID=205;

select sum(CostOfService) as TotalCost from couriers where CostOfService <(select max(CostOfService) from couriers);

-- 52 Find all couriers that have been paid for (Exist):
select * from couriers c where exists (select * from payment p where p.CourierID=c.CourierID);

-- 53 Find the locations where the maximum payment amount was made 
select LocationID, amount from payment where Amount = (select max(Amount) from payment);

-- 54 Find all couriers whose weight is greater than the weight of all couriers sent by a specific sender
select * from couriers where weight >all (select weight from couriers where senderid = 102);


