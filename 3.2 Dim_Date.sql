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
