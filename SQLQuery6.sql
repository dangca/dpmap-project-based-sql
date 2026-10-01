USE Insurance
GO

--Exec SPGetOutstandingRTPublish

-- Query 1
SELECT ClaimantID, ReopenedDate
FROM Claimant
  
-- Query 2
SELECT PK, max(EnteredOn) as LastSavedOn
FROM ReservingTool
WHERE IsSaved = 1
GROUP BY ClaimNumber
