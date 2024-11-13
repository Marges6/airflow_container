SELECT
	soh.SalesOrderNumber,
	soh.OrderDate,
	soh.DueDate,
	soh.ShipDate,
	soh.ModifiedDate,
	soh.OnlineOrderFlag,
	c.AccountNumber as CustomerAccountNumber,
    CONCAT(p2.FirstName, ' ',COALESCE(p2.MiddleName + ' ', ''), p2.LastName) as SalesPersonName,
	st.CountryRegionCode as CountryCode,
    st.Name as TerritoryName,
	st.[Group] as TerritoryGroupName,
	sm.Name as ShippingCompany,
	COALESCE(cr.ToCurrencyCode,'USD') as OriginalTransCurrency,
	p.ProductNumber,
	sod.OrderQty,
	ROUND(sod.UnitPrice, 2) AS UnitPrice,
	ROUND(sod.UnitPriceDiscount, 2) AS UnitPriceDiscount,
	ROUND(sod.LineTotal, 2) AS LineTotal,
	ROUND(soh.SubTotal, 2) AS SubTotal,
	ROUND(soh.TaxAmt, 2) AS TaxAmt,
	ROUND(soh.Freight, 2) AS Freight,
	ROUND(soh.TotalDue, 2) AS TotalDue	
FROM
	AdventureWorks2022.Sales.SalesOrderHeader soh
INNER JOIN
	AdventureWorks2022.Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID 
INNER JOIN
	AdventureWorks2022.Production.Product p ON sod.ProductID = p.ProductID
INNER JOIN
	AdventureWorks2022.Purchasing.ShipMethod sm  ON soh.ShipMethodID = sm.ShipMethodID
INNER JOIN
	AdventureWorks2022.Sales.Customer c ON soh.CustomerID = c.CustomerID
LEFT JOIN
	AdventureWorks2022.Sales.CurrencyRate cr ON soh.CurrencyRateID = cr.CurrencyRateID 
INNER JOIN
	AdventureWorks2022.Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
LEFT JOIN
	AdventureWorks2022.Person.Person p2 ON soh.SalesPersonID = p2.BusinessEntityID 
ORDER BY OrderDate
	