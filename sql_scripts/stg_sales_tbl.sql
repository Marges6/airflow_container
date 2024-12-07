CREATE TABLE IF NOT EXISTS arf.stg_sales (
	SalesOrderNumber VARCHAR(10),
	OrderDate DATE,
	DueDate DATE,
	ShipDate DATE,
	ModifiedDate DATE,
	OnlineOrderFlag BOOLEAN,
	CustomerAccountNumber VARCHAR(10),
	SalesPersonName VARCHAR(100),
	CountryCode VARCHAR(10),
    TerritoryName VARCHAR(30),
	TerritoryGroupName VARCHAR(30),
	ShippingCompany VARCHAR(150),
	OriginalTransCurrency VARCHAR(3),
	ProductNumber VARCHAR(30),
	OrderQty SMALLINT,
	UnitPrice NUMERIC(7,2),
	UnitPriceDiscount NUMERIC(7,2),
	LineTotal NUMERIC(9,2),
	SubTotal NUMERIC(9,2),
	TaxAmt NUMERIC(8,2),
	Freight NUMERIC(7,2),
	TotalDue NUMERIC(12,2),
	LoadDateTime TIMESTAMP 
);