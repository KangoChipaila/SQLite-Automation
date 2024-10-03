CREATE TABLE SalesFact(
	OrderNumber INT PRIMARY KEY,
	QuantityOrdered INT,
	PriceEach INT,
	Sales INT AS (QuantityOrdered * PriceEach),
	OrderDate INT,
	ProductCode INT,
	CustomerKey INT,
	DealSize TEXT,
	FOREIGN KEY (OrderDate) REFERENCES DateDim (DateKey),
	FOREIGN KEY (ProductCode) REFERENCES ProductDim (ProductKey),
	FOREIGN KEY (CustomerKey) REFERENCES CustomerDim (CustomerKey)
);

CREATE TABLE "DateDim" (
	"DateKey"	INT,
	"OrderDate"	TEXT,
	"Quarter"	TEXT GENERATED ALWAYS AS (
		CASE 
			WHEN CAST("Month" AS INTEGER) BETWEEN 1 AND 3 THEN '1' 
			WHEN CAST("Month" AS INTEGER) BETWEEN 4 AND 6 THEN '2' 
			WHEN CAST("Month" AS INTEGER) BETWEEN 7 AND 9 THEN '3' 
			ELSE '4' 
		END),
		
	"Month"	TEXT GENERATED ALWAYS AS 
		(
			CASE 
				WHEN substr("OrderDate", 2, 1) = '/' THEN substr("OrderDate", 1, 1) 
				ELSE substr("OrderDate", 1, 2) 
			END
		),
		
	"Year" TEXT GENERATED ALWAYS AS 
		(
			CASE
				WHEN substr("OrderDate", 4, 1) = '/' THEN substr("OrderDate", 5, 4)
				WHEN substr("OrderDate", 5, 1) = '/' THEN substr("OrderDate", 6, 4)
				ELSE substr("OrderDate", 7, 4) 
			END
		),
		
	PRIMARY KEY("DateKey")
);

CREATE TABLE ProductDim(
	ProductKey INT PRIMARY KEY,
	ProductCode TEXT, 
	ProductLine TEXT,
	MSRP INT
);

CREATE TABLE CustomerDim(
	CustomerKey INT PRIMARY KEY,
	CustomerName TEXT,
	Phone TEXT,
	AddressLine1 TEXT,
	AddressLine2 TEXT,
	City TEXT,
	State TEXT,
	PostalCode TEXT,
	Country TEXT,
	Territory TEXT,
	ContactLastName TEXT,
	ContactFirstName TEXT
);



