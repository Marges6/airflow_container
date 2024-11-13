SELECT
	AccountNumber AS CustomerAccountNumber,
	COALESCE(s.Name,CONCAT(p.FirstName, ' ',COALESCE(p.MiddleName + ' ', ''), p.LastName)) AS CustomerName,
	CASE WHEN PersonID IS NULL THEN 1 ELSE 0 END AS StoreFlag,
--	CustomerID,
--	PersonID,
--	StoreID,
--	TerritoryID,
--	bea.AddressID,
	at2.Name AS AddressType,
	CONCAT(a.AddressLine1,COALESCE(a.AddressLine2,'')) AS AddressLines,
	a.City,
	a.PostalCode,
	sp.StateProvinceCode,
	sp.Name AS StateProvinceName,
	sp.CountryRegionCode AS CountryCode,
	st.Name AS TerritoryName,
	st.[Group] AS TerritoryGroupName,
	GETUTCDATE() AS LoadDateTimeUTC
	--	rowguid
--	ModifiedDate
FROM
	AdventureWorks2022.Sales.Customer c
LEFT JOIN
	AdventureWorks2022.Sales.Store s ON c.StoreID = s.BusinessEntityID 
LEFT JOIN
	AdventureWorks2022.Person.Person p ON c.PersonID = p.BusinessEntityID 
LEFT JOIN
	AdventureWorks2022.Person.BusinessEntityAddress bea  ON COALESCE(c.PersonID,c.StoreID) = bea.BusinessEntityID
INNER JOIN
	AdventureWorks2022.Person.Address a ON bea.AddressID = a.AddressID
INNER JOIN
	AdventureWorks2022.Person.AddressType at2 ON bea.AddressTypeID = at2.AddressTypeID
INNER JOIN
	AdventureWorks2022.Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
INNER JOIN
	AdventureWorks2022.Sales.SalesTerritory st ON st.TerritoryID = sp.TerritoryID 

 
