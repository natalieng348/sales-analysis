-- Cleaned Dim_Customers Table --
SELECT 
  [CustomerKey],
  --,[GeographyKey]
  --,[CustomerAlternateKey]
  --,[Title]
  c.firstname AS [First Name], 
  --,[MiddleName]
  c.LastName AS [Last Name],
  c.firstname + ' ' + c.lastname AS [Full Name],
  --,[NameStyle]
  --,[BirthDate]
  --,[MaritalStatus]
  --,[Suffix] 
  CASE c.Gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender, 
  --,[EmailAddress]
  --,[YearlyIncome]
  --,[TotalChildren]
  --,[NumberChildrenAtHome]
  --,[EnglishEducation]
  --,[SpanishEducation]
  --,[FrenchEducation]
  --,[EnglishOccupation]
  --,[SpanishOccupation]
  --,[FrenchOccupation]
  --,[HouseOwnerFlag]
  --,[NumberCarsOwned]
  --,[AddressLine1]
  --,[AddressLine2]
  --,[Phone]
  c.datefirstpurchase AS DateFirstPurchase, 
  --,[CommuteDistance]
  g.city AS [Customer City],							-- Joined in Customer City from the Geography Table
  g.StateProvinceName AS [Customer State],				-- Joined in Customer State from the Geography Table
  g.EnglishCountryRegionName AS [Customer Country]		-- Joined in Customer Country from the Geography Table
FROM 
  [dbo].[DimCustomer] AS c 
  LEFT JOIN [dbo].[DimGeography] AS g ON g.GeographyKey = c.GeographyKey 
ORDER BY 
  CustomerKey ASC -- Order list by CustomerKey
