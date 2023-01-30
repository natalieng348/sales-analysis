# Data Analysis Project: Sales Management 

![image](https://user-images.githubusercontent.com/96028654/215404057-d23ba1a6-8424-4889-a2a9-8990037ff2b0.png)

## Project Objective

* Perform a detailed analysis using SQL and create interactive dashboards with PowerBI for Internet Sales to facilitate a business request. 

## Languages & Tools

* Language: SQL
* Database: Microsoft SQL Server Management Studio
* Data Visualization: Microsoft Power BI
* Data Source: [Adventure Works Sample Databases 2019](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver15&tabs=ssms)

## Project Outline

### [**1. Business Request & User Stories**](https://github.com/natalieng348/Sales_Analysis_Project/tree/main/1.%20Business%20Demand%20and%20Project%20Planning)

* The business request for this data analysis project was to create an executive sales report for the Sales Department. Based on the request that was made from the business, user stories were defined to fulfill delivery and ensure the acceptance criteria were maintained throughout the project.

* User Stories:

| # | Role | Request | User Value | Acceptance Criteria |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| 1 | Sales Manager | To get a dashboard overview of internet sales | Can follow better which customers and products sells the best | A Power BI dashboard which updates data once a day |
| 2 | Sales Representative | A detailed overview of Internet Sales per Customers | Can follow up my customers that buys the most and who we can sell more to | A Power BI dashboard which allows me to filter data for each customer |
| 3 | Sales Representative | A detailed overview of Internet Sales per Products | Can follow up my Products that sells the most | A Power BI dashboard which allows me to filter data for each Product |
| 4 | Sales Manager | A dashboard overview of internet sales | Can follow sales over time against budget | A Power Bi dashboard with graphs and KPIs comparing against budget. |

<br>

### [**2. Data Cleaning & Transformation**](https://github.com/natalieng348/Sales_Analysis_Project/tree/main/2.%20Data%20Cleaning%20%26%20Transformation)

* To create the necessary data model for doing analysis and fulfilling the business needs defined in the user stories the following table were extracted using SQL.
* Below are the SQL statements for cleaning and transforming necessary data.<br><br>
    * **DIM_Calendar:**
    ```
    -- Cleaned Dim_Date Table --
    SELECT 
      [DateKey], 
      [FullDateAlternateKey] AS Date, 
      --[DayNumberOfWeek],
      [EnglishDayNameOfWeek] AS Day, 
      --[SpanishDayNameOfWeek],
      --[FrenchDayNameOfWeek],
      --[DayNumberOfMonth],
      --[DayNumberOfYear],
      --[WeekNumberOfYear],
      --[EnglishMonthName], 
      LEFT([EnglishMonthName],3) AS Month,
      --[SpanishMonthName],
      --[FrenchMonthName],
      [MonthNumberOfYear] AS MonthNo, 
      [CalendarQuarter] AS Quarter, 
      [CalendarYear] AS Year 
      --[CalendarSemester],
      --[FiscalQuarter],
      --[FiscalYear],
      --[FiscalSemester],
    FROM 
      [dbo].[DimDate] 
    WHERE 
      CalendarYear >= 2019
    ```
    <br>
    
     * **DIM_Customers:**
    ```
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
      g.city AS [Customer City],		                        -- Joined in Customer City from the Geography Table
      g.StateProvinceName AS [Customer State],		        -- Joined in Customer State from the Geography Table
      g.EnglishCountryRegionName AS [Customer Country]		-- Joined in Customer Country from the Geography Table
    FROM 
      [dbo].[DimCustomer] AS c 
      LEFT JOIN [dbo].[DimGeography] AS g ON g.GeographyKey = c.GeographyKey 
    ORDER BY 
      CustomerKey ASC -- Order list by CustomerKey
    ```
    
     * **DIM_Products:**
    ```
    -- Cleaned Dim_Products Table --
    SELECT 
      p.[ProductKey], 
      [ProductAlternateKey] AS [Product Item Code],
      --,[ProductSubcategoryKey]
      --,[WeightUnitMeasureCode]
      --,[SizeUnitMeasureCode] 
      p.[EnglishProductName] AS [Product Name],
      ps.[EnglishProductSubcategoryName] AS [Sub Category],       -- Joined in from Sub Category table
      pc.[EnglishProductCategoryName] AS [Product Category],      -- Joined in from Category table
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
    ```
    
     * **FACT_InternetSales:**
    ```
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
    ```
    
    <br>
    
### Data Model

* Below is a screenshot of the data model after data cleaning and tables were loaded into Power BI.
* This data model also shows how FACT_Budget is connected to FACT_InternetSales and other DIM tables.
![image](https://user-images.githubusercontent.com/96028654/190928468-4a2c336a-24db-4638-b025-7677323b33bc.png)

<br>
 
### [**3. Data Visualization**](https://github.com/natalieng348/Sales_Analysis_Project/tree/main/3.%20Data%20Visualization)

* To assist the decision making process, the sales managers can view the [interactive sales management dashboard](https://app.powerbi.com/view?r=eyJrIjoiNGM2NTQyNjktODE5YS00NmIxLWJjYjItZmE3OTlhM2EzYzk2IiwidCI6ImQxNzU2NzliLWFjZDMtNDY0NC1iZTgyLWFmMDQxOTgyOTc3YSIsImMiOjZ9&pageName=ReportSection18107e9d881b492fe8c8) which consists of an overview page and two additional pages focusing on customer data and product data over time.

[![image](https://user-images.githubusercontent.com/96028654/190933620-bfce393c-485d-47fd-84eb-92c0b3623215.png)](https://app.powerbi.com/view?r=eyJrIjoiNGM2NTQyNjktODE5YS00NmIxLWJjYjItZmE3OTlhM2EzYzk2IiwidCI6ImQxNzU2NzliLWFjZDMtNDY0NC1iZTgyLWFmMDQxOTgyOTc3YSIsImMiOjZ9&pageName=ReportSection18107e9d881b492fe8c8)
[![image](https://user-images.githubusercontent.com/96028654/190929087-de7fdccb-f67a-4ee6-a7e2-084f5b5bff20.png)](https://app.powerbi.com/view?r=eyJrIjoiNGM2NTQyNjktODE5YS00NmIxLWJjYjItZmE3OTlhM2EzYzk2IiwidCI6ImQxNzU2NzliLWFjZDMtNDY0NC1iZTgyLWFmMDQxOTgyOTc3YSIsImMiOjZ9&pageName=ReportSection18107e9d881b492fe8c8)
[![image](https://user-images.githubusercontent.com/96028654/190929147-825f3128-4603-442e-be5c-783f99075e9c.png)](https://app.powerbi.com/view?r=eyJrIjoiNGM2NTQyNjktODE5YS00NmIxLWJjYjItZmE3OTlhM2EzYzk2IiwidCI6ImQxNzU2NzliLWFjZDMtNDY0NC1iZTgyLWFmMDQxOTgyOTc3YSIsImMiOjZ9&pageName=ReportSection18107e9d881b492fe8c8)


## Issues 

In case of any difficulties or issues while running the app, please raise it on the issues section. 

## Pull Requests

If you have something to add or new idea to implement, you are welcome to create a pull requests on improvement.
