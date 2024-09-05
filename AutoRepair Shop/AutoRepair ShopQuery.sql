-- CUSTOMER ANALYSIS 
-- Identify the top 5 customers who have spent the most on vehicle repairs and parts.
SELECT Customer.CustomerID, Customer.Name AS CustomerName, SUM(Invoice.Total) AS TotalSpent
FROM Customer
INNER JOIN Invoice ON Customer.CustomerID = Invoice.CustomerID
GROUP BY Customer.CustomerID, Customer.Name
ORDER BY TotalSpent DESC
LIMIT 5;

-- Determine the average spending of customers on repairs and parts.
SELECT AVG(total_spent) as Average_Spending
FROM (
    SELECT Customer.CustomerID, SUM(Invoice.Total) as Total_Spent
    FROM Customer
    JOIN Invoice ON Customer.CustomerID = Invoice.CustomerID
    GROUP BY Customer.CustomerID
) as Customer_Spending;

-- Analyze the frequency of customer visits and identify any patterns.
SELECT Customer.CustomerID, Customer.Name, COUNT(Invoice.InvoiceID) AS NumberOfVisits
FROM Customer
JOIN Vehicle ON Customer.Name = Vehicle.OwnerName
JOIN Invoice ON Customer.CustomerID = Invoice.CustomerID
GROUP BY Customer.CustomerID, Customer.Name
ORDER BY NumberOfVisits DESC;


-- VEHICLE ANALYSIS 
-- Calculate the average mileage of vehicles serviced.
SELECT AVG(Mileage) AS AverageMileage
FROM Vehicle;
 
-- Identify the Most Common Vehicle Makes and Models Brought in for Service
SELECT Make, Model, COUNT(Vehicleid) as count
FROM Vehicle
GROUP BY Make, Model
ORDER BY count DESC;

-- Analyze the distribution of vehicle ages and identify any trends in service requirements based on vehicle age.
SELECT YEAR(CURDATE()) - Year AS VehicleAge, COUNT(*) AS NumberOfVehicles
FROM Vehicle
GROUP BY VehicleAge
ORDER BY VehicleAge DESC;


-- JOB PERFORMANCE ANALYSIS 
-- Determine the most common types of jobs performed and their frequency.
SELECT Description, COUNT(*) AS Frequency
FROM Job
GROUP BY Description
ORDER BY Frequency DESC;

-- Calculate the Total Revenue Generated from Each Type of Job
SELECT Description, SUM(Amount) AS TotalRevenue
FROM Job
GROUP BY Description
ORDER BY TotalRevenue DESC;

-- Identify the Jobs with the Highest and Lowest Average Costs
-- Jobs with the highest average cost
SELECT Job.Description, AVG(Job.Amount) AS average_cost
FROM Job
GROUP BY Job.Description
ORDER BY average_cost DESC 
LIMIT 3;

-- Jobs with the lowest average cost
SELECT Job.Description, AVG(Job.Amount) AS average_cost
FROM Job
GROUP BY Job.Description
ORDER BY average_cost ASC
LIMIT 3; 
  

-- PARTS USAGE ANALYSIS 
-- List the Top 5 Most Frequently Used Parts and Their Total Usage
SELECT Parts.PartName, SUM(Parts.Quantity) AS total_usage
FROM Parts
GROUP BY Parts.PartName
ORDER BY total_usage DESC
LIMIT 5;

-- Calculate the Average Cost of Parts Used in Repairs
SELECT AVG(UnitPrice) AS AverageCost
FROM Parts;

-- Determine the Total Revenue Generated from Parts Sales
SELECT SUM(Amount) AS TotalPartsRevenue
FROM Parts;


-- FINANCIAL ANALYSIS 
-- Calculate the total revenue generated from labor and parts for each month.
SELECT DATE_FORMAT(Invoice.InvoiceDate, '%Y-%m') AS Month, 
       SUM(COALESCE(Job.Amount, 0)) AS TotalLaborRevenue, 
       SUM(COALESCE(Parts.Amount, 0)) AS TotalPartsRevenue, 
       SUM(COALESCE(Job.Amount, 0) + COALESCE(Parts.Amount, 0)) AS TotalRevenue
FROM Invoice
JOIN Job ON Invoice.InvoiceID = Job.InvoiceID
JOIN Parts ON Invoice.InvoiceID = Parts.InvoiceID
GROUP BY DATE_FORMAT(Invoice.InvoiceDate, '%Y-%m')
ORDER BY Month;

-- Determine the overall profitability of the repair shop
SELECT
  SUM(COALESCE(Invoice.Total, 0)) AS TotalRevenue,
  SUM(COALESCE(Job.Amount, 0)) AS TotalLaborCost,
  SUM(COALESCE(Parts.Amount, 0)) AS TotalPartsCost,
  SUM(COALESCE(Invoice.Total, 0)) - SUM(COALESCE(Job.Amount, 0)) - SUM(COALESCE(Parts.Amount, 0)) AS Profit
FROM Invoice
INNER JOIN Job ON Invoice.InvoiceID = Job.InvoiceID
INNER JOIN Parts ON Invoice.InvoiceID = Parts.InvoiceID;

-- Analyze the impact of sales tax on the total revenue.
SELECT SUM(SalesTax) AS TotalSalesTax, SUM(Total) AS TotalRevenue, 
       (SUM(SalesTax) / SUM(Total)) * 100 AS SalesTaxPercentage
FROM Invoice;