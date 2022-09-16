-- Cleaned Fact_InternetSales table -- 
SELECT 
  [ProductKey], 
  [OrderDateKey], 
  [DueDateKey], 
  [ShipDateKey], 
  [CustomerKey],
  --,[PromotionKey]
  --,[CurrencyKey]
  --,[SalesTerritoryKey] 
  [SalesOrderNumber],
  --,[SalesOrderLineNumber]
  --,[RevisionNumber]
  --,[OrderQuantity]
  --,[UnitPrice]
  --,[ExtendedAmount]
  --,[UnitPriceDiscountPct]
  --,[DiscountAmount]
  --,[ProductStandardCost]
  --,[TotalProductCost]
  [SalesAmount]
  --,[TaxAmt]
  --,[Freight]
  --,[CarrierTrackingNumber]
  --,[CustomerPONumber]
  --,[OrderDate]
  --,[DueDate]
  --,[ShipDate]
FROM 
  [dbo].[FactInternetSales] 
WHERE 
  LEFT(OrderDateKey, 4) >= YEAR(GETDATE())-2		-- Ensures to only return order date within two years of date 
ORDER BY 
  OrderDateKey ASC
