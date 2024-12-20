-- creating staging customers table
CREATE TABLE IF NOT EXISTS arf.stg_customers (
	CustomerAccountNumber VARCHAR(10),
	CustomerName VARCHAR(255),
	StoreFlag BOOLEAN,
	AddressType VARCHAR(50),
	AddressLines VARCHAR(255),
	City VARCHAR(100),
	PostalCode VARCHAR(20),
	StateProvinceCode VARCHAR(10),
	StateProvinceName VARCHAR(50),
	CountryCode VARCHAR(10),
	TerritoryName VARCHAR(30),
	TerritoryGroupName VARCHAR(30),
	LoadDateTime TIMESTAMP 
);