

-- Junk Dimension
  --A Junk Dimension consolidates miscellaneous attributes that don't fit neatly into other dimensions.
CREATE TABLE Order_Junk_Dimension (
    JunkID SERIAL PRIMARY KEY,
    OrderPriority VARCHAR(50),
    OrderType VARCHAR(50)
);

-- Insert some combinations of attributes
INSERT INTO Order_Junk_Dimension (OrderPriority, OrderType)
VALUES ('High', 'Online'),
       ('Low', 'In-Store'),
       ('Medium', 'Online');

-- Query the Junk Dimension
SELECT * FROM Order_Junk_Dimension;



--Degenerate Dimension

  --A Degenerate Dimension is a dimension that does not have its own dimension table but exists in the fact table.
  
  -- Fact table with degenerate dimension
CREATE TABLE Sales_Fact (
    SalesID SERIAL PRIMARY KEY,
    OrderNumber VARCHAR(50), -- Degenerate Dimension
    ProductID INT,
    CustomerID INT,
    SalesAmount DECIMAL(10, 2),
    SalesDate DATE
);
INSERT INTO Sales_Fact (SalesID, OrderNumber,ProductID,CustomerID,SalesAmount,SalesDate)
VALUES (1,123,5445,9009,900,'2024-08-17'),
       (2,124,5446,9010,500,'2024-08-17'),
        (3,124,5447,9011,900,'2024-08-17');


-- Query that uses the degenerate dimension
SELECT OrderNumber, SUM(SalesAmount)
FROM Sales_Fact
GROUP BY OrderNumber;



--Role-Playing Dimension
  --A Role-Playing Dimension is a single dimension that can play multiple roles in the fact table.

CREATE TABLE Date_Dimension (
    DateID INT PRIMARY KEY,
    FullDate DATE,
    Day INT,
    Month INT,
    Year INT,
    Weekday VARCHAR(50)
);

-- Used in the fact table as different roles
CREATE TABLE Sales_Fact (
    SalesID INT PRIMARY KEY,
    OrderDateID INT,
    ShipDateID INT,
    DeliveryDateID INT,
    SalesAmount DECIMAL(10, 2),
    FOREIGN KEY (OrderDateID) REFERENCES Date_Dimension(DateID),
    FOREIGN KEY (ShipDateID) REFERENCES Date_Dimension(DateID),
    FOREIGN KEY (DeliveryDateID) REFERENCES Date_Dimension(DateID)
);


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



