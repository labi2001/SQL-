CREATE DATABASE AutoRepairDatabase;

USE AutoRepairDatabase;

CREATE TABLE DateDimension (
    Date_ID INT AUTO_INCREMENT PRIMARY KEY,
    Date DATE NOT NULL,
    Day_of_Week VARCHAR(10),
    Month INT,
    Quarter INT,
    Season VARCHAR(10), 
    Year INT
);

CREATE TABLE Location (
    Location_ID INT AUTO_INCREMENT PRIMARY KEY,
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100)
);

CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) UNIQUE,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20)
);

CREATE TABLE Vehicle (
    VehicleID INT AUTO_INCREMENT PRIMARY KEY,
    Make VARCHAR(50),
    Model VARCHAR(50),
    Year INT,
    Color VARCHAR(50),
    VIN VARCHAR(50) UNIQUE,
    RegNumber VARCHAR(50),
    Mileage INT,
    CustomerID INT,  -- Change to CustomerID for proper FK relation
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)  -- Foreign key reference to Customer table
);

CREATE TABLE Invoice (
    InvoiceID INT AUTO_INCREMENT PRIMARY KEY,
    InvoiceDate DATE,
    Subtotal DECIMAL(10, 2),
    SalesTaxRate DECIMAL(5, 2),
    SalesTax DECIMAL(10, 2),
    TotalLabor DECIMAL(10, 2),
    TotalPart DECIMAL(10, 2),
    Total DECIMAL(10, 2),
    CustomerID INT,
    VehicleID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID)
);

CREATE TABLE Job (
    JobID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleID INT,
    Description VARCHAR(255),
    Hours DECIMAL(5, 2),
    Rate DECIMAL(10, 2),
    Amount DECIMAL(10, 2),
    InvoiceID INT,
    FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID),
    FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID)
);

CREATE TABLE Parts (
    PartID INT AUTO_INCREMENT PRIMARY KEY,
    JobID INT,
    PartNumber VARCHAR(50),
    PartName VARCHAR(255),
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    Amount DECIMAL(10, 2),
    InvoiceID INT,
    FOREIGN KEY (JobID) REFERENCES Job(JobID),
    FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID)
);

-- Indexes for date table
CREATE INDEX idx_date_date_id ON DateDimension(Date_ID);

-- Indexes for customer table
CREATE INDEX idx_customer_name ON Customer(Name);

-- Indexes for vehicle table
CREATE INDEX idx_vehicle_make_model ON Vehicle(Make, Model);
CREATE INDEX idx_vehicle_vin ON Vehicle(VIN);

-- Indexes for job table
CREATE INDEX idx_job_vehicle_id ON Job(VehicleID);

-- Indexes for parts table
CREATE INDEX idx_parts_job_id ON Parts(JobID);

-- Indexes for invoice table
CREATE INDEX idx_invoice_customer_id ON Invoice(CustomerID);
CREATE INDEX idx_invoice_vehicle_id ON Invoice(VehicleID);
CREATE INDEX idx_invoice_date ON Invoice(InvoiceDate);
