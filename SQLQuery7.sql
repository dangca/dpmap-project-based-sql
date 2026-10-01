SELECT *
FROM Insurance.dbo.Attachment
WHERE EnteredBy = 'lnikki'
  AND FileName like '%.pdf'

SELECT *
FROM Insurance.dbo.ReserveType

SELECT * 
FROM Insurance.dbo.ReserveType
WHERE reserveTypeID = 1 OR ParentID = 1

SELECT ClaimantID, COUNT(*) AS ReserveChangeCount
FROM Insurance.dbo.Reserve
GROUP BY ClaimantID
HAVING COUNT(*) >= 15

SELECT TOP 0 *
INTO Insurance.dbo.Claim2
FROM Insurance.dbo.Claim

SELECT RIGHT(FileName, 4) as AttachmentType, COUNT(1) as Counts
FROM Insurance.dbo.Attachment
GROUP BY RIGHT(FileName, 4)
ORDER BY COUNT(1) DESC
