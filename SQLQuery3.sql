SELECT *
INTO Insurance.dbo.Office2
FROM Insurance.dbo.Office

SELECT TOP 10 BusinessName, COUNT(BusinessName) as Employees
INTO Insurance.dbo.Top10Inc
FROM Insurance.dbo.Patient
WHERE BusinessName like '%inc%'
GROUP BY BusinessName
ORDER BY Count(BusinessName) DESC

SELECT *
FROM Insurance.dbo.Attachment
WHERE fileName like '%.ppt%' or filename like '%.doc%'

SELECT EnteredBy
    , COUNT(*) as NumberOfPublishes
FROM Insurance.dbo.ReservingTool
WHERE IsPublished = 1
GROUP BY EnteredBy
HAVING COUNT(*) > 50
