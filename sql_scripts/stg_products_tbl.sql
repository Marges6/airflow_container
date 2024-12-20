CREATE TABLE IF NOT EXISTS arf.stg_products (
	ProductNumber VARCHAR(30),
	Name VARCHAR(150),
	Description VARCHAR(255),
	MakeFlag BOOLEAN,
	FinishedGoodsFlag BOOLEAN,
	Color VARCHAR(15),
	SafetyStockLevel SMALLINT,
	ReorderPoint SMALLINT,
	StandardCost NUMERIC(7,2),
	ListPrice NUMERIC(7,2),
	Size SMALLINT,
	SizeUnitMeasureCode VARCHAR(10),
	WeightUnitMeasureCode VARCHAR(10),
	Weight NUMERIC(5,2),
	DaysToManufacture SMALLINT,
	ProductLine VARCHAR(2),
	Class VARCHAR(2),
	Style VARCHAR(2),
	ProductSubcategoryName VARCHAR(50),
	ProductCategoryName VARCHAR(50),
	ProductModelName VARCHAR(100),
	SellStartDate DATE,
	SellEndDate DATE,
	LoadDateTime TIMESTAMP 
);