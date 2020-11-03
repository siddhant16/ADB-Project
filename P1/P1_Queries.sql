CREATE TABLE Orders (
Order_id INT NOT NULL,
Ordered_Date DateTime NOT NULL,
Order_Status VARCHAR(50) NOT NULL,
Quantity_Ordered INT NOT NULL,
PriceOfEach INT,
PRIMARY KEY (Order_id)
);

DESCRIBE Orders;

CREATE TABLE Customer(
Order_Id INT NOT NULL,
CustomerID INT NOT NULL,
Customer_Name VARCHAR(50),
Customer_Address VARCHAR(75), 
PRIMARY KEY(CustomerID),
FOREIGN KEY(Order_id) REFERENCES Orders(Order_id)
);

DESCRIBE Customer;

INSERT INTO Orders VALUES
(1001, '2019-05-19', 'Delivered', 40, 135 ),
(1012, '2020-01-02', 'In Transit', 15, 1100 ),
(1023, '2019-12-17', 'Shipped', 1, 14200 ),
(1025, '2020-01-02', 'Processing', 9, 300 ),
(1027, '2019-12-19', 'In Transit', 11, 4100 ),
(1030, '2020-01-04', 'Out For Delivery', 30, 1770 ),
(1032, '2019-12-02', 'In Transit', 100, 2060 ),
(2004, '2019-11-10', 'Delivered', 80, 510 ),
(2010, '2019-10-22', 'Shipped', 35, 800 ),
(2203, '2019-12-19', 'Processing', 60, 1255 ),
(3107, '2020-01-07', 'In Transit', 55, 1515 );

SELECT *FROM Orders;

INSERT INTO Customer VALUES
(1001, 23, 'Ross Geller', '5 Morton Street, New York'),
(1023, 29, 'Monica Cox', '495 Grove Street, New York'),
(1025, 32, 'Chandler Bing', '1050 Benton Street, California'),
(1032, 44, 'Joey Tribbiani', '90 Bedford St. Apt. 19, New York'),
(2004, 47, 'Rachel Green', 'Lighthouse Management and Media, Los Angeles'),
(2010, 48, 'Phoebe Buffay', '8391 Beverly Blvd, California'),
(2203, 59, 'Gunther', '1409 Cold Canyon Rd,, California'),
(3107, 67, 'Mike Hannigan', '601 Buena Vista Avenue West, Georgia');

Select *FROM Customer;

UPDATE Orders SET Order_Status = 'Out For Delivery'
WHERE Order_Id = 3107;

SELECT *FROM Orders WHERE Order_Id = 3107;

DELETE FROM Customer Where CustomerID = 67;
SELECT *FROM Customer;

SELECT *FROM Orders INNER JOIN Customer ON Orders.Order_Id = Customer.Order_Id;
SELECT *FROM Orders LEFT JOIN Customer ON Orders.Order_Id = Customer.Order_Id;
SELECT *FROM Orders RIGHT JOIN Customer ON Orders.Order_Id = Customer.Order_Id;

SELECT *FROM Orders ORDER BY Quantity_Ordered ASC;

SELECT *, COUNT(*) FROM Orders 
INNER JOIN Customer ON Orders.Order_Id = Customer.Order_Id
GROUP BY Order_Status;

SELECT MAX(PriceOFEach) FROM Orders;
SELECT MIN(Quantity_Ordered) FROM Orders;
SELECT COUNT(*) FROM Customer;
SELECT AVG(PriceOfEach) As Average_Price FROM Orders;
SELECT SUM(Quantity_Ordered) As TotalQuantity FROM Orders;