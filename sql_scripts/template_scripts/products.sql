SELECT
	p.ProductNumber,
	p.Name,
	pd.Description,
	p.MakeFlag,
	p.FinishedGoodsFlag,
	p.Color,
	p.SafetyStockLevel,
	p.ReorderPoint,
	p.StandardCost,
	p.ListPrice,
	p.[Size],
	p.SizeUnitMeasureCode,
	p.WeightUnitMeasureCode,
	p.Weight,
	p.DaysToManufacture,
	p.ProductLine,
	p.Class,
	p.[Style],
	ps.Name AS ProductSubcategoryName,
	pc.Name AS ProductCategoryName,
	pm.Name AS ProductModelName,
	p.SellStartDate,
	p.SellEndDate
FROM
	AdventureWorks2022.Production.Product p
INNER JOIN 
	AdventureWorks2022.Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID 
INNER JOIN
	AdventureWorks2022.Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID 
INNER JOIN
	AdventureWorks2022.Production.ProductModel pm ON p.ProductModelID = pm.ProductModelID
INNER JOIN
	AdventureWorks2022.Production.ProductModelProductDescriptionCulture pmpdc ON pm.ProductModelID = pmpdc.ProductModelID AND pmpdc.CultureID = 'en'
INNER JOIN
	AdventureWorks2022.Production.ProductDescription pd  ON pmpdc.ProductDescriptionID  = pd.ProductDescriptionID 
	




	