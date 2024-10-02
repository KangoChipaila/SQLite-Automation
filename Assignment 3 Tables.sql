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

CREATE TABLE DateDim(
	DateKey INT PRIMARY KEY,
	OrderDate TEXT,
	Quarter TEXT AS
		(
			CASE 
				WHEN CAST (substr(OrderDate, 6, 2) AS INTEGER) BETWEEN 1 AND 3 THEN '01'
				WHEN CAST (substr(OrderDate, 6, 2) AS INTEGER) BETWEEN 4 AND 6 THEN '02'
				WHEN CAST (substr(OrderDate, 6, 2) AS INTEGER) BETWEEN 7 AND 9 THEN '03'
				ELSE '04'
			END
		),
	Month TEXT AS (substr(OrderDate, 6, 2)),
	Year TEXT AS (substr(OrderDate, 1, 4))
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



