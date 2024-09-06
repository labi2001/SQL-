CREATE DATABASE InvoiceData;

USE InvoiceData;

CREATE TABLE Dimension_Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY, 
    CustomerName VARCHAR (100),
    Address VARCHAR (255),
    Phone VARCHAR (20)
);

CREATE TABLE Dimension_Vehicle (
    VehicleID INT AUTO_INCREMENT PRIMARY KEY,
    Make VARCHAR (50),
    Model VARCHAR (50),
    Year INT,
    Color VARCHAR (50),
    VIN VARCHAR (50),
    RegistrationNumber VARCHAR (30),
    Mileage INT 
);

CREATE TABLE Dimension_Service (
    ServiceID INT AUTO_INCREMENT PRIMARY KEY, 
    JobDescription VARCHAR(255),
    Rate DECIMAL(10, 2),
    Hours INT 
);

CREATE TABLE Dimension_Parts (
    PartID INT AUTO_INCREMENT PRIMARY KEY,
    PartName VARCHAR(255),
    PartNumber VARCHAR(50),
    UnitPrice DECIMAL(10, 2)
); 

CREATE TABLE Dimension_Location (
    LocationID INT AUTO_INCREMENT PRIMARY KEY, 
    LocationName VARCHAR (100),
    Address VARCHAR (255)
);

CREATE TABLE Dimension_Date (
    DateID INT AUTO_INCREMENT PRIMARY KEY,
    Date DATE,
    DueDate DATE,
    Year INT,
    Quarter INT,
    Month INT
);

CREATE TABLE FactInvoice(
    InvoiceID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT, 
    VehicleID INT, 
    ServiceID INT, 
    PartsID INT,  
    LocationID INT, 
    DateID INT, 
    Total_Labour DECIMAL(10, 2),
    Total_Parts DECIMAL(10, 2),
    Sales_Tax DECIMAL(10, 2),
    Total_Sales DECIMAL(10, 2),
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Dimension_Customer(CustomerID),
    FOREIGN KEY (VehicleID) REFERENCES Dimension_Vehicle(VehicleID),
    FOREIGN KEY (ServiceID) REFERENCES Dimension_Service(ServiceID),
    FOREIGN KEY (PartsID) REFERENCES Dimension_Parts(PartID),
    FOREIGN KEY (LocationID) REFERENCES Dimension_Location(LocationID),
    FOREIGN KEY (DateID) REFERENCES Dimension_Date(DateID)
);
