USE ElectricalStoreDB;
GO

/* =========================================================
   ELECTRICAL STORE - SQL QUERIES
   ========================================================= */


------------------------------------------------------------
-- 1. Display all customers
------------------------------------------------------------

SELECT *
FROM Customers;


------------------------------------------------------------
-- 2. Display all products
------------------------------------------------------------

SELECT *
FROM Products;


------------------------------------------------------------
-- 3. Display products with price greater than 20000
------------------------------------------------------------

SELECT ProductID, ProductName, Price, Quantity
FROM Products
WHERE Price > 20000;


------------------------------------------------------------
-- 4. Display products with quantity less than 20
------------------------------------------------------------

SELECT ProductID, ProductName, Quantity
FROM Products
WHERE Quantity < 20;


------------------------------------------------------------
-- 5. Display products between 5000 and 20000
------------------------------------------------------------

SELECT ProductID, ProductName, Price
FROM Products
WHERE Price BETWEEN 5000 AND 20000;


------------------------------------------------------------
-- 6. Display products ordered by price
------------------------------------------------------------

SELECT ProductID, ProductName, Price
FROM Products
ORDER BY Price ASC;


------------------------------------------------------------
-- 7. Display most expensive products
------------------------------------------------------------

SELECT TOP 10
    ProductID,
    ProductName,
    Price
FROM Products
ORDER BY Price DESC;


------------------------------------------------------------
-- 8. Display cheapest products
------------------------------------------------------------

SELECT TOP 10
    ProductID,
    ProductName,
    Price
FROM Products
ORDER BY Price ASC;


------------------------------------------------------------
-- 9. Display products with warranty 24 months or more
------------------------------------------------------------

SELECT
    ProductID,
    ProductName,
    WarrantyMonths
FROM Products
WHERE WarrantyMonths >= 24;


------------------------------------------------------------
-- 10. Search products containing 'TV'
------------------------------------------------------------

SELECT *
FROM Products
WHERE ProductName LIKE '%TV%';


------------------------------------------------------------
-- 11. Search customers from Cairo
------------------------------------------------------------

SELECT *
FROM Customers
WHERE Address LIKE '%Cairo%';


------------------------------------------------------------
-- 12. Display customers with email
------------------------------------------------------------

SELECT *
FROM Customers
WHERE Email IS NOT NULL;


------------------------------------------------------------
-- 13. Count customers
------------------------------------------------------------

SELECT COUNT(*) AS TotalCustomers
FROM Customers;


------------------------------------------------------------
-- 14. Count products
------------------------------------------------------------

SELECT COUNT(*) AS TotalProducts
FROM Products;


------------------------------------------------------------
-- 15. Calculate average product price
------------------------------------------------------------

SELECT AVG(Price) AS AveragePrice
FROM Products;


------------------------------------------------------------
-- 16. Calculate maximum product price
------------------------------------------------------------

SELECT MAX(Price) AS MaximumPrice
FROM Products;


------------------------------------------------------------
-- 17. Calculate minimum product price
------------------------------------------------------------

SELECT MIN(Price) AS MinimumPrice
FROM Products;


------------------------------------------------------------
-- 18. Calculate total inventory quantity
------------------------------------------------------------

SELECT SUM(Quantity) AS TotalInventory
FROM Products;


------------------------------------------------------------
-- 19. Calculate total sales
------------------------------------------------------------

SELECT SUM(TotalAmount) AS TotalSales
FROM Orders;


------------------------------------------------------------
-- 20. Calculate average order value
------------------------------------------------------------

SELECT AVG(TotalAmount) AS AverageOrderValue
FROM Orders;


------------------------------------------------------------
-- 21. Display orders greater than 50000
------------------------------------------------------------

SELECT *
FROM Orders
WHERE TotalAmount > 50000;


------------------------------------------------------------
-- 22. Display orders sorted by total amount
------------------------------------------------------------

SELECT *
FROM Orders
ORDER BY TotalAmount DESC;


------------------------------------------------------------
-- 23. Display latest orders
------------------------------------------------------------

SELECT TOP 10 *
FROM Orders
ORDER BY OrderDate DESC;


------------------------------------------------------------
-- 24. Display employees with salary greater than 10000
------------------------------------------------------------

SELECT *
FROM Employees
WHERE Salary > 10000;


------------------------------------------------------------
-- 25. Display employees ordered by salary
------------------------------------------------------------

SELECT
    EmployeeID,
    FullName,
    JobTitle,
    Salary
FROM Employees
ORDER BY Salary DESC;


------------------------------------------------------------
-- 26. Count employees by job title
------------------------------------------------------------

SELECT
    JobTitle,
    COUNT(*) AS NumberOfEmployees
FROM Employees
GROUP BY JobTitle;


------------------------------------------------------------
-- 27. Average salary by job title
------------------------------------------------------------

SELECT
    JobTitle,
    AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY JobTitle;


------------------------------------------------------------
-- 28. Total salary by job title
------------------------------------------------------------

SELECT
    JobTitle,
    SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY JobTitle;


------------------------------------------------------------
-- 29. Products with Category information
------------------------------------------------------------

SELECT
    P.ProductID,
    P.ProductName,
    C.CategoryName,
    P.Price,
    P.Quantity
FROM Products P
INNER JOIN Categories C
    ON P.CategoryID = C.CategoryID;


------------------------------------------------------------
-- 30. Products with Brand information
------------------------------------------------------------

SELECT
    P.ProductID,
    P.ProductName,
    B.BrandName,
    P.Price
FROM Products P
INNER JOIN Brands B
    ON P.BrandID = B.BrandID;


------------------------------------------------------------
-- 31. Products with Supplier information
------------------------------------------------------------

SELECT
    P.ProductID,
    P.ProductName,
    S.SupplierName,
    P.Price,
    P.Quantity
FROM Products P
INNER JOIN Suppliers S
    ON P.SupplierID = S.SupplierID;


------------------------------------------------------------
-- 32. Full product information
------------------------------------------------------------

SELECT
    P.ProductID,
    P.ProductName,
    C.CategoryName,
    B.BrandName,
    S.SupplierName,
    P.Price,
    P.Quantity,
    P.WarrantyMonths
FROM Products P
INNER JOIN Categories C
    ON P.CategoryID = C.CategoryID
INNER JOIN Brands B
    ON P.BrandID = B.BrandID
INNER JOIN Suppliers S
    ON P.SupplierID = S.SupplierID;


------------------------------------------------------------
-- 33. Orders with customer names
------------------------------------------------------------

SELECT
    O.OrderID,
    C.FullName AS CustomerName,
    O.OrderDate,
    O.TotalAmount
FROM Orders O
INNER JOIN Customers C
    ON O.CustomerID = C.CustomerID;


------------------------------------------------------------
-- 34. Orders with employee names
------------------------------------------------------------

SELECT
    O.OrderID,
    E.FullName AS EmployeeName,
    O.OrderDate,
    O.TotalAmount
FROM Orders O
INNER JOIN Employees E
    ON O.EmployeeID = E.EmployeeID;


------------------------------------------------------------
-- 35. Complete order information
------------------------------------------------------------

SELECT
    O.OrderID,
    C.FullName AS CustomerName,
    E.FullName AS EmployeeName,
    O.OrderDate,
    O.TotalAmount
FROM Orders O
INNER JOIN Customers C
    ON O.CustomerID = C.CustomerID
INNER JOIN Employees E
    ON O.EmployeeID = E.EmployeeID;


------------------------------------------------------------
-- 36. Order details with product information
------------------------------------------------------------

SELECT
    OD.OrderDetailID,
    OD.OrderID,
    P.ProductName,
    OD.Quantity,
    OD.UnitPrice,
    OD.Quantity * OD.UnitPrice AS LineTotal
FROM OrderDetails OD
INNER JOIN Products P
    ON OD.ProductID = P.ProductID;


------------------------------------------------------------
-- 37. Complete order details
------------------------------------------------------------

SELECT
    O.OrderID,
    C.FullName AS CustomerName,
    P.ProductName,
    OD.Quantity,
    OD.UnitPrice,
    OD.Quantity * OD.UnitPrice AS LineTotal,
    O.OrderDate
FROM Orders O
INNER JOIN Customers C
    ON O.CustomerID = C.CustomerID
INNER JOIN OrderDetails OD
    ON O.OrderID = OD.OrderID
INNER JOIN Products P
    ON OD.ProductID = P.ProductID;


------------------------------------------------------------
-- 38. Total quantity sold for each product
------------------------------------------------------------

SELECT
    P.ProductID,
    P.ProductName,
    SUM(OD.Quantity) AS TotalQuantitySold
FROM Products P
INNER JOIN OrderDetails OD
    ON P.ProductID = OD.ProductID
GROUP BY
    P.ProductID,
    P.ProductName
ORDER BY TotalQuantitySold DESC;


------------------------------------------------------------
-- 39. Total sales by product
------------------------------------------------------------

SELECT
    P.ProductID,
    P.ProductName,
    SUM(OD.Quantity * OD.UnitPrice) AS TotalSales
FROM Products P
INNER JOIN OrderDetails OD
    ON P.ProductID = OD.ProductID
GROUP BY
    P.ProductID,
    P.ProductName
ORDER BY TotalSales DESC;


------------------------------------------------------------
-- 40. Number of orders per customer
------------------------------------------------------------

SELECT
    C.CustomerID,
    C.FullName,
    COUNT(O.OrderID) AS NumberOfOrders
FROM Customers C
LEFT JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY
    C.CustomerID,
    C.FullName
ORDER BY NumberOfOrders DESC;


------------------------------------------------------------
-- 41. Total amount spent by each customer
------------------------------------------------------------

SELECT
    C.CustomerID,
    C.FullName,
    SUM(O.TotalAmount) AS TotalSpent
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY
    C.CustomerID,
    C.FullName
ORDER BY TotalSpent DESC;


------------------------------------------------------------
-- 42. Customers who spent more than 50000
------------------------------------------------------------

SELECT
    C.CustomerID,
    C.FullName,
    SUM(O.TotalAmount) AS TotalSpent
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY
    C.CustomerID,
    C.FullName
HAVING SUM(O.TotalAmount) > 50000;


------------------------------------------------------------
-- 43. Number of products per category
------------------------------------------------------------

SELECT
    C.CategoryID,
    C.CategoryName,
    COUNT(P.ProductID) AS NumberOfProducts
FROM Categories C
LEFT JOIN Products P
    ON C.CategoryID = P.CategoryID
GROUP BY
    C.CategoryID,
    C.CategoryName
ORDER BY NumberOfProducts DESC;


------------------------------------------------------------
-- 44. Average product price by category
------------------------------------------------------------

SELECT
    C.CategoryName,
    AVG(P.Price) AS AveragePrice
FROM Categories C
INNER JOIN Products P
    ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryName
ORDER BY AveragePrice DESC;


------------------------------------------------------------
-- 45. Number of products per brand
------------------------------------------------------------

SELECT
    B.BrandID,
    B.BrandName,
    COUNT(P.ProductID) AS NumberOfProducts
FROM Brands B
LEFT JOIN Products P
    ON B.BrandID = P.BrandID
GROUP BY
    B.BrandID,
    B.BrandName
ORDER BY NumberOfProducts DESC;


------------------------------------------------------------
-- 46. Products supplied by each supplier
------------------------------------------------------------

SELECT
    S.SupplierID,
    S.SupplierName,
    COUNT(P.ProductID) AS NumberOfProducts
FROM Suppliers S
LEFT JOIN Products P
    ON S.SupplierID = P.SupplierID
GROUP BY
    S.SupplierID,
    S.SupplierName
ORDER BY NumberOfProducts DESC;


------------------------------------------------------------
-- 47. Purchase details with supplier
------------------------------------------------------------

SELECT
    PU.PurchaseID,
    S.SupplierName,
    PU.PurchaseDate,
    PU.TotalAmount
FROM Purchases PU
INNER JOIN Suppliers S
    ON PU.SupplierID = S.SupplierID;


------------------------------------------------------------
-- 48. Purchase details with products
------------------------------------------------------------

SELECT
    PD.PurchaseDetailID,
    PU.PurchaseID,
    P.ProductName,
    PD.Quantity,
    PD.UnitCost,
    PD.Quantity * PD.UnitCost AS PurchaseTotal
FROM PurchaseDetails PD
INNER JOIN Purchases PU
    ON PD.PurchaseID = PU.PurchaseID
INNER JOIN Products P
    ON PD.ProductID = P.ProductID;


------------------------------------------------------------
-- 49. Total purchases
------------------------------------------------------------

SELECT
    SUM(TotalAmount) AS TotalPurchases
FROM Purchases;


------------------------------------------------------------
-- 50. Total purchase amount by supplier
------------------------------------------------------------

SELECT
    S.SupplierID,
    S.SupplierName,
    SUM(PU.TotalAmount) AS TotalPurchases
FROM Suppliers S
INNER JOIN Purchases PU
    ON S.SupplierID = PU.SupplierID
GROUP BY
    S.SupplierID,
    S.SupplierName
ORDER BY TotalPurchases DESC;


------------------------------------------------------------
-- 51. Employees who handled orders
------------------------------------------------------------

SELECT
    E.EmployeeID,
    E.FullName,
    COUNT(O.OrderID) AS NumberOfOrders
FROM Employees E
LEFT JOIN Orders O
    ON E.EmployeeID = O.EmployeeID
GROUP BY
    E.EmployeeID,
    E.FullName
ORDER BY NumberOfOrders DESC;


------------------------------------------------------------
-- 52. Sales handled by each employee
------------------------------------------------------------

SELECT
    E.EmployeeID,
    E.FullName,
    SUM(O.TotalAmount) AS TotalSales
FROM Employees E
INNER JOIN Orders O
    ON E.EmployeeID = O.EmployeeID
GROUP BY
    E.EmployeeID,
    E.FullName
ORDER BY TotalSales DESC;


------------------------------------------------------------
-- 53. Employees with sales above 50000
------------------------------------------------------------

SELECT
    E.EmployeeID,
    E.FullName,
    SUM(O.TotalAmount) AS TotalSales
FROM Employees E
INNER JOIN Orders O
    ON E.EmployeeID = O.EmployeeID
GROUP BY
    E.EmployeeID,
    E.FullName
HAVING SUM(O.TotalAmount) > 50000;


------------------------------------------------------------
-- 54. Products below average price
------------------------------------------------------------

SELECT
    ProductID,
    ProductName,
    Price
FROM Products
WHERE Price < (
    SELECT AVG(Price)
    FROM Products
);


------------------------------------------------------------
-- 55. Products above average price
------------------------------------------------------------

SELECT
    ProductID,
    ProductName,
    Price
FROM Products
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
);


------------------------------------------------------------
-- 56. Most expensive product
------------------------------------------------------------

SELECT
    ProductID,
    ProductName,
    Price
FROM Products
WHERE Price = (
    SELECT MAX(Price)
    FROM Products
);


------------------------------------------------------------
-- 57. Cheapest product
------------------------------------------------------------

SELECT
    ProductID,
    ProductName,
    Price
FROM Products
WHERE Price = (
    SELECT MIN(Price)
    FROM Products
);


------------------------------------------------------------
-- 58. Customers who placed orders
------------------------------------------------------------

SELECT *
FROM Customers
WHERE CustomerID IN
(
    SELECT CustomerID
    FROM Orders
);


------------------------------------------------------------
-- 59. Customers who never placed an order
------------------------------------------------------------

SELECT
    C.CustomerID,
    C.FullName
FROM Customers C
LEFT JOIN Orders O
    ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL;


------------------------------------------------------------
-- 60. Products that were sold
------------------------------------------------------------

SELECT
    P.ProductID,
    P.ProductName
FROM Products P
WHERE EXISTS
(
    SELECT 1
    FROM OrderDetails OD
    WHERE OD.ProductID = P.ProductID
);


------------------------------------------------------------
-- 61. Products that were never sold
------------------------------------------------------------

SELECT
    P.ProductID,
    P.ProductName
FROM Products P
WHERE NOT EXISTS
(
    SELECT 1
    FROM OrderDetails OD
    WHERE OD.ProductID = P.ProductID
);


------------------------------------------------------------
-- 62. Orders with calculated total
------------------------------------------------------------

SELECT
    O.OrderID,
    O.TotalAmount AS StoredTotal,
    SUM(OD.Quantity * OD.UnitPrice) AS CalculatedTotal
FROM Orders O
INNER JOIN OrderDetails OD
    ON O.OrderID = OD.OrderID
GROUP BY
    O.OrderID,
    O.TotalAmount;


------------------------------------------------------------
-- 63. Check order total differences
------------------------------------------------------------

SELECT
    O.OrderID,
    O.TotalAmount AS StoredTotal,
    SUM(OD.Quantity * OD.UnitPrice) AS CalculatedTotal,
    O.TotalAmount - SUM(OD.Quantity * OD.UnitPrice) AS Difference
FROM Orders O
INNER JOIN OrderDetails OD
    ON O.OrderID = OD.OrderID
GROUP BY
    O.OrderID,
    O.TotalAmount;


------------------------------------------------------------
-- 64. Orders between two dates
------------------------------------------------------------

SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2026-01-01' AND '2026-02-28';


------------------------------------------------------------
-- 65. Purchases between two dates
------------------------------------------------------------

SELECT *
FROM Purchases
WHERE PurchaseDate BETWEEN '2026-02-01' AND '2026-03-31';


------------------------------------------------------------
-- 66. Total sales by order date
------------------------------------------------------------

SELECT
    OrderDate,
    SUM(TotalAmount) AS DailySales
FROM Orders
GROUP BY OrderDate
ORDER BY OrderDate;


------------------------------------------------------------
-- 67. Total purchases by purchase date
------------------------------------------------------------

SELECT
    PurchaseDate,
    SUM(TotalAmount) AS DailyPurchases
FROM Purchases
GROUP BY PurchaseDate
ORDER BY PurchaseDate;


------------------------------------------------------------
-- 68. Products with stock greater than 30
------------------------------------------------------------

SELECT
    ProductID,
    ProductName,
    Quantity
FROM Products
WHERE Quantity > 30
ORDER BY Quantity DESC;


------------------------------------------------------------
-- 69. Low stock products
------------------------------------------------------------

SELECT
    ProductID,
    ProductName,
    Quantity
FROM Products
WHERE Quantity <= 10
ORDER BY Quantity ASC;


------------------------------------------------------------
-- 70. Inventory value for each product
------------------------------------------------------------

SELECT
    ProductID,
    ProductName,
    Price,
    Quantity,
    Price * Quantity AS InventoryValue
FROM Products
ORDER BY InventoryValue DESC;


------------------------------------------------------------
-- 71. Total inventory value
------------------------------------------------------------

SELECT
    SUM(Price * Quantity) AS TotalInventoryValue
FROM Products;


------------------------------------------------------------
-- 72. Product information with stock status
------------------------------------------------------------

SELECT
    ProductID,
    ProductName,
    Quantity,
    CASE
        WHEN Quantity <= 10 THEN 'Low Stock'
        WHEN Quantity <= 30 THEN 'Medium Stock'
        ELSE 'High Stock'
    END AS StockStatus
FROM Products;


------------------------------------------------------------
-- 73. Product price classification
------------------------------------------------------------

SELECT
    ProductID,
    ProductName,
    Price,
    CASE
        WHEN Price < 5000 THEN 'Low Price'
        WHEN Price BETWEEN 5000 AND 20000 THEN 'Medium Price'
        ELSE 'High Price'
    END AS PriceCategory
FROM Products;


------------------------------------------------------------
-- 74. Customer and order information
------------------------------------------------------------

SELECT
    C.FullName,
    C.PhoneNumber,
    O.OrderID,
    O.OrderDate,
    O.TotalAmount
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
ORDER BY O.TotalAmount DESC;


------------------------------------------------------------
-- 75. Supplier and purchased products
------------------------------------------------------------

SELECT
    S.SupplierName,
    P.ProductName,
    PD.Quantity,
    PD.UnitCost
FROM Suppliers S
INNER JOIN Products P
    ON S.SupplierID = P.SupplierID
INNER JOIN PurchaseDetails PD
    ON P.ProductID = PD.ProductID;


------------------------------------------------------------
-- 76. Top 10 customers by spending
------------------------------------------------------------

SELECT TOP 10
    C.CustomerID,
    C.FullName,
    SUM(O.TotalAmount) AS TotalSpent
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY
    C.CustomerID,
    C.FullName
ORDER BY TotalSpent DESC;


------------------------------------------------------------
-- 77. Top 10 employees by sales
------------------------------------------------------------

SELECT TOP 10
    E.EmployeeID,
    E.FullName,
    SUM(O.TotalAmount) AS TotalSales
FROM Employees E
INNER JOIN Orders O
    ON E.EmployeeID = O.EmployeeID
GROUP BY
    E.EmployeeID,
    E.FullName
ORDER BY TotalSales DESC;


------------------------------------------------------------
-- 78. Top 10 products by sales quantity
------------------------------------------------------------

SELECT TOP 10
    P.ProductID,
    P.ProductName,
    SUM(OD.Quantity) AS QuantitySold
FROM Products P
INNER JOIN OrderDetails OD
    ON P.ProductID = OD.ProductID
GROUP BY
    P.ProductID,
    P.ProductName
ORDER BY QuantitySold DESC;


------------------------------------------------------------
-- 79. Total sales and purchases
------------------------------------------------------------

SELECT
    (SELECT SUM(TotalAmount) FROM Orders) AS TotalSales,
    (SELECT SUM(TotalAmount) FROM Purchases) AS TotalPurchases;


------------------------------------------------------------
-- 80. Estimated gross difference
------------------------------------------------------------

SELECT
    (SELECT SUM(TotalAmount) FROM Orders)
    -
    (SELECT SUM(TotalAmount) FROM Purchases)
    AS SalesPurchaseDifference;
