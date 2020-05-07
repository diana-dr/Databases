USE BREWERY

CREATE TABLE ProductTypes 
(typeID INT PRIMARY KEY,
 typeName varchar(50) NOT NULL)

 CREATE TABLE Product
 (productID INT PRIMARY KEY,
 productName varchar(50) NOT NULL,
 productPrice INT,
 expirationDate date,
 typeID INT FOREIGN KEY REFERENCES ProductTypes(typeID))

 CREATE TABLE Ingredients
 (ingredientID INT PRIMARY KEY,
 ingredientName varchar(50) NOT NULL,
 ingredientQuantity INT)

 CREATE TABLE product_ingredients
 (productID INT FOREIGN KEY REFERENCES Product(productID),
 ingredientID INT FOREIGN KEY REFERENCES Ingredients(ingredientID)
 CONSTRAINT pk PRIMARY KEY(productID, ingredientID))

 CREATE TABLE Suppliers
 (supplierID INT PRIMARY KEY,
 supplierName varchar(50) NOT NULL,
 information varchar(500) NOT NULL)

 CREATE TABLE supplier_ingredients
 (supplierID INT FOREIGN KEY REFERENCES Suppliers(supplierID),
 ingredientID INT FOREIGN KEY REFERENCES Ingredients(ingredientID)
 CONSTRAINT pk PRIMARY KEY(supplierID, ingredientID))

 CREATE TABLE OrderDetails
 (detailsID INT PRIMARY KEY,
 details varchar(100),
 arrivalDate date,
 productID INT FOREIGN KEY REFERENCES Product(productID))

 CREATE TABLE Order_
 (orderID INT PRIMARY KEY,
 orderName varchar(100),
 detailsID INT FOREIGN KEY REFERENCES OrderDetails(detailsID))

 CREATE TABLE Customers
 (customerID INT PRIMARY KEY,
 custumerName varchar(50),
 orderID INT FOREIGN KEY REFERENCES Order_(orderID))

 CREATE TABLE Employee
 (employeeID INT PRIMARY KEY,
 employeeName varchar(50),
 employeeSalary INT) 

 --inserting data
 INSERT INTO ProductTypes VALUES 
					(101, 'Cider'),
					(102, 'Flavored beer'),
					(103, 'Non alcoholic beer'),
					(104, 'Malt'),
					(105, 'Stout'),
					(1101, 'Cider'),
					(1102, 'Flavored beer'),
					(1103, 'Non alcoholic beer'),
					(1104, 'Malt'),
					(1105, 'Stout');

 INSERT INTO Product VALUES 
					(0, 'Pear Cider', 10, '2022-02-19', 101),
					(1, 'Apple Cider', 10, '2023-02-19', 101),
					(2, 'Lemon Beer', 11, '2023-02-19', 102),
					(3, 'Non alcoholic beer', 7, '2022-03-19', 103),
					(4, 'Berry cider', 10, '2023-04-19', 101),
					(5, 'Blonde Beer', 15, '2022-07-19', 104),
					(110, 'Cider', 10, '2022-02-19', 1101),
					(111, 'Gold Apples Cider', 10, '2023-02-19', 1101),
					(112, 'Grepfruit Beer', 11, '2023-02-19', 1102),
					(113, 'Dark beer', 7, '2022-03-19', 1103),
					(114, 'Srawberry cider', 10, '2023-04-19', 1101),
					(115, 'Lime Beer', 15, '2022-07-19', 1104);
					-- (2, 'Grepfruit Beer', 11, '2024-02-19', 102); -- using a taken id

INSERT INTO Ingredients VALUES 
					(100, 'water', 100),
					(101, 'apples', 50),
					(102, 'hops', 190),
					(103, 'yeast', 200),
					(104, 'lemons', 1100),
					(105, 'barley', 3100),
					(1100, 'strawberry', 1010),
					(1101, 'golden apples', 501),
					(1102, 'grepfruit', 1901),
					(1103, 'limes', 2001),
					(1104, 'berries', 1001);

INSERT INTO product_ingredients VALUES
					(1, 101),
					(2, 104),
					(3, 100);

INSERT INTO Suppliers VALUES
					(100, 'Hopsteiner', 'Supplier for hops.'),
					(101, 'Country Malt', 'Supplier for brewing yeast.'),
					(102, 'Fresh direct', 'Supplier for fruits.'),
					(103, 'MDECA Group SRL', 'Supplier for barley.');

INSERT INTO supplier_ingredients VALUES
					(100, 102),
					(101, 103),
					(102, 101),
					(102, 104),
					(103, 105);

INSERT INTO OrderDetails VALUES
					(100, 'Order to Kaufland from 2019-10-31 for 500 bottles', '2019-11-03', 10),
					(101, 'Order to Careffour from 2019-11-05 for 10 cases', '2019-11-10', 1),
					(102, 'Order to Penny from 2019-11-3 for 100 bottles', '2019-11-6', 2),
					(103, 'Order to Kaufland from 2019-11-12 for 50 cases', '2019-11-15', 3),
					(104, 'Order to Auchan from 2019-12-01 for 100 cases', '2019-12-03', 4),
					(105, 'Order to Lidl from 2019-11-19 for 100 bottles', '2019-11-23', 5),
					(1100, 'Order to Kaufland from 2019-10-31 for 500 bottles', '2019-12-03', 10),
					(1101, 'Order to Careffour from 2019-11-05 for 10 cases', '2019-12-10', 1),
					(1102, 'Order to Penny from 2019-11-3 for 100 bottles', '2019-12-6', 2),
					(1103, 'Order to Kaufland from 2019-11-12 for 50 cases', '2019-12-15', 3),
					(1104, 'Order to Auchan from 2019-12-01 for 100 cases', '2019-11-03', 4),
					(1105, 'Order to Lidl from 2019-11-19 for 100 bottles', '2019-12-23', 5);

INSERT INTO Order_ VALUES
					(110, 'Order for Pear Cider', 100),
					(111, 'Order for Apple Cider', 101),
					(112, 'Order for Lemon Beer', 102),
					(113, 'Order for non alcoholic beer', 103),
					(114, 'Order for Berry Cider', 104),
					(115, 'Order for Blonde Beer', 105),
					(1110, 'Order for Pear Cider', 1100),
					(1111, 'Order for Apple Cider', 1101),
					(1112, 'Order for Lemon Beer', 1102),
					(1113, 'Order for non alcoholic beer', 1103),
					(1114, 'Order for Berry Cider', 1104),
					(1115, 'Order for Blonde Beer', 1105);

INSERT INTO Customers VALUES
					(100, 'Kaufland', 110),
					(101, 'Careffour', 111),
					(102, 'Penny', 112),
					(103, 'Auchan', 114),
					(104, 'Lidl', 115),
					(1100, 'Kaufland', 1110),
					(1101, 'Careffour', 1111),
					(1102, 'Penny', 1112),
					(1103, 'Auchan', 1114),
					(1104, 'Lidl', 1115);

INSERT INTO Employee VALUES
					(100, 'John Doe 1', 1500),
					(101, 'John Doe 2', 3000),
					(102, 'Jane Doe 1', 4040),
					(103, 'Jane Doe 2', 5000),
					(104, 'John Doe 3', 1900),
					(605, 'JAne Doe 3', 2000);

--update data in 3 tables
UPDATE Ingredients
SET ingredientQuantity = 200
WHERE ingredientID >= 102

UPDATE Product
SET expirationDate = '2025-02-19'
WHERE productPrice IS NOT NULL

UPDATE Employee
SET employeeSalary = 5000
WHERE employeeName LIKE 'Jane%'

--delete data from 3 tables
DELETE FROM Order_
WHERE orderID > 113

DELETE FROM Employee
WHERE employeeName NOT LIKE 'John%'

DELETE FROM Customers
WHERE custumerName LIKE 'K%' OR customerID BETWEEN 102 AND 104

-- 2 queries with the union operation
SELECT *
FROM ProductTypes
WHERE typeName LIKE 'C_%'
UNION
SELECT * 
FROM ProductTypes
WHERE typeID > 103

SELECT s.productName
FROM Product s
WHERE productName LIKE '%l%'
UNION ALL
SELECT s1.productName
FROM Product s1
WHERE s1.productPrice > 10
ORDER BY productName

-- intersection operation
SELECT TOP 3 *
FROM Ingredients
WHERE ingredientName LIKE '%l%'
INTERSECT
SELECT *
FROM Ingredients
WHERE ingredientQuantity > 150

SELECT *
FROM Product
WHERE productID > 101
INTERSECT
SELECT *
FROM Product
WHERE productName LIKE '%l%'

-- difference operation
SELECT c1.custumerName
FROM Customers c1
WHERE c1.custumerName NOT LIKE '%n%'
EXCEPT 
SELECT c2.custumerName
FROM Customers c2
WHERE c2.customerID > 101
ORDER BY custumerName

SELECT *
FROM Ingredients i
WHERE i.ingredientName LIKE '%n%'
EXCEPT 
SELECT *
FROM Ingredients i1
WHERE i1.ingredientID > 150
ORDER BY ingredientName

-- 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN; 
-- one query will join at least 3 tables, while another one will join at least two many-to-many relationships;
SELECT *
FROM Ingredients i RIGHT JOIN Product p ON
i.ingredientID = p.productID

SELECT TOP 5 *
FROM Product p LEFT OUTER JOIN Suppliers s ON
p.productID = s.supplierID

SELECT *
FROM ProductTypes t
INNER JOIN Product p ON t.typeID = p.productID
INNER JOIN Ingredients i ON p.productID = i.ingredientID

SELECT Product.productID, Ingredients.ingredientID
FROM Product
LEFT OUTER JOIN product_ingredients ON Product.productID = product_ingredients.productID
LEFT OUTER JOIN Ingredients ON product_ingredients.ingredientID = Ingredients.ingredientID 
UNION
SELECT Ingredients.ingredientID, Suppliers.supplierID
FROM Suppliers
LEFT OUTER JOIN supplier_ingredients ON Suppliers.supplierID = supplier_ingredients.supplierID
LEFT OUTER JOIN Ingredients ON supplier_ingredients.ingredientID = Ingredients.ingredientID 


--e. 2 queries using the IN operator to introduce a subquery in the WHERE clause; 
--in at least one query, the subquery should include a subquery in its own WHERE clause;
--f. 2 queries using the EXISTS operator to introduce a subquery in the WHERE clause;
--g. 2 queries with a subquery in the FROM clause;   

SELECT s.supplierID, s.supplierName 
FROM Customers c INNER JOIN Suppliers s ON
c.customerID=s.supplierID 
WHERE s.supplierName LIKE '%l%'

SELECT s.supplierID, s.supplierName 
FROM Suppliers s
WHERE supplierName LIKE '%l%' AND s.supplierID IN (SELECT c.custumerName FROM Customers c) 

SELECT s.supplierID, s.supplierName 
FROM Suppliers s  
WHERE supplierName LIKE '%l%' AND EXISTS (SELECT * FROM Customers c      
								WHERE c.customerID = s.supplierID) 

SELECT A.supplierID, A.supplierName 
FROM (SELECT c.customerID, s.supplierID, s.supplierName    
	FROM Customers c
	INNER JOIN Suppliers s ON c.customerID = s.supplierID    
	WHERE supplierName LIKE '%l%') A 

SELECT p.productID, p.productName 
FROM Product p
WHERE productPrice > 100 AND p.productID IN (SELECT t.typeName FROM ProductTypes t) 

SELECT p.productID, p.productName 
FROM Product p  
WHERE productPrice > 100 AND EXISTS (SELECT * FROM ProductTypes t      
								WHERE t.typeID = p.productID) 

SELECT B.productID, B.productName 
FROM (SELECT p.productID, t.typeID, p.productName    
	FROM ProductTypes t
	INNER JOIN Product p ON t.typeID = p.productID    
	WHERE productPrice > 100) B

-- h. 4 queries with the GROUP BY clause, 3 of which also contain the HAVING clause; 
-- 2 of the latter will also have a subquery in the HAVING clause; 
-- use the aggregation operators: COUNT, SUM, AVG, MIN, MAX;

SELECT t.typeID, AVG(p.productPrice) 
FROM ProductTypes t INNER JOIN Product p ON t.typeID = p.productID 
WHERE t.typeID <= 200 
GROUP BY t.typeID

SELECT t.typeID, AVG(p.productPrice) 
FROM ProductTypes t INNER JOIN Product p ON t.typeID = p.productID 
GROUP BY t.typeID
HAVING AVG(p.productPrice) >= 100

SELECT i.ingredientID
FROM Ingredients i
WHERE i.ingredientQuantity > 200
GROUP BY i.ingredientID
having count(*) = 
	(
		select COUNT(*) from Ingredients i
		INNER JOIN ProductTypes t on t.typeID = i.ingredientID
		INNER JOIN Product p on p.productID = i.ingredientID
		GROUP BY  i.ingredientID
	) 

SELECT s.supplierName
FROM Suppliers s
WHERE s.supplierID < 105
GROUP BY s.supplierName
having count(*) = 
	(
		select COUNT(*) from Suppliers s
		INNER JOIN ProductTypes t on t.typeID = s.supplierID
		INNER JOIN Product p on p.productID = s.supplierID
		GROUP BY  s.supplierID
	) 

-- i. 4 queries using ANY and ALL
SELECT p.productID, p.productPrice FROM Product p  
WHERE p.productPrice > ALL( SELECT p1.productPrice      
							FROM Product p1      
							WHERE p.productID = p1.productID)

SELECT i.ingredientName, i.ingredientID FROM Ingredients i  
WHERE i.ingredientQuantity NOT IN ( SELECT i1.ingredientQuantity      
									FROM Ingredients i1      
									WHERE i.ingredientID = i1.ingredientID) 

SELECT c.custumerName, c.customerID FROM Customers c
WHERE c.customerID < ANY ( SELECT c1.customerID      
					FROM Customers c1      
					WHERE c.customerID = c1.customerID) 

SELECT p.productName FROM Product p 
WHERE p.productPrice IN (SELECT p1.productPrice      
					FROM Product p1      
					WHERE p.productID = p1.productID)

/*SELECT * FROM Ingredients;
SELECT * FROM Product;
SELECT * FROM ProductTypes;
SELECT * FROM Suppliers;
SELECT * FROM Order_;
SELECT * FROM OrderDetails;
SELECT * FROM Customers;
SELECT * FROM Employee;
SELECT * FROM product_ingredients;
SELECT * FROM supplier_ingredients;*/