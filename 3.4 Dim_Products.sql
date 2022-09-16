-- Cleaned Dim_Products Table --
SELECT 
  p.[ProductKey], 
  [ProductAlternateKey] AS [Product Item Code],
  --,[ProductSubcategoryKey]
  --,[WeightUnitMeasureCode]
  --,[SizeUnitMeasureCode] 
  p.[EnglishProductName] AS [Product Name],
  ps.[EnglishProductSubcategoryName] AS [Sub Category],			-- Joined in from Sub Category table
  pc.[EnglishProductCategoryName] AS [Product Category],			-- Joined in from Category table
  --,[SpanishProductName]
  --,[FrenchProductName]
  --,[StandardCost]
  --,[FinishedGoodsFlag]
  [Color] AS [Product Color],
  --,[SafetyStockLevel]
  --,[ReorderPoint]
  --,[ListPrice]
  [Size] AS [Product Size], 
  --,[SizeRange]
  --,[Weight]
  --,[DaysToManufacture] 
  [ProductLine] AS [Product Line], 
  --,[DealerPrice]
  --,[Class]
  --,[Style]
   
  [ModelName] AS [Product Model Name], 
  --,[LargePhoto]
  [EnglishDescription] AS [Product Description],
  --,[FrenchDescription]
  --,[ChineseDescription]
  --,[ArabicDescription]
  --,[HebrewDescription]
  --,[ThaiDescription]
  --,[GermanDescription]
  --,[JapaneseDescription]
  --,[TurkishDescription]
  --,[StartDate]
  --,[EndDate] 
  ISNULL (P.Status, 'Outdated') AS [Product Status] 
FROM 
  dbo.DimProduct as p 
  LEFT JOIN dbo.DimProductSubcategory AS ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey 
  LEFT JOIN dbo.DimProductCategory AS pc ON pc.ProductCategoryKey = p.ProductSubcategoryKey 
ORDER BY 
  p.ProductKey ASC
