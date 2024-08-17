
--Outrigger Dimension
  --An Outrigger Dimension is a dimension table that is linked to another dimension table.


CREATE TABLE Location_Dimension (
    LocationID INT PRIMARY KEY,
    City VARCHAR(255),
    State VARCHAR(255),
    Country VARCHAR(255)
);

CREATE TABLE Customer_Dimension (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    LocationID INT,
    FOREIGN KEY (LocationID) REFERENCES Location_Dimension(LocationID)
);


--Conformed Dimension
  --A Conformed Dimension is a dimension that is shared across multiple fact tables.

CREATE TABLE Date_Dimension (
    DateID INT PRIMARY KEY,
    FullDate DATE,
    Day INT,
    Month INT,
    Year INT
);

-- Used in multiple fact tables
CREATE TABLE Sales_Fact (
    SalesID INT PRIMARY KEY,
    DateID INT,
    SalesAmount DECIMAL(10, 2),
    FOREIGN KEY (DateID) REFERENCES Date_Dimension(DateID)
);

CREATE TABLE Inventory_Fact (
    InventoryID INT PRIMARY KEY,
    DateID INT,
    Quantity INT,
    FOREIGN KEY (DateID) REFERENCES Date_Dimension(DateID)
);



