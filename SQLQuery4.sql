SELECT  [LogID]
        ,[PK]
        ,[FieldName]
        ,[OldValue]
        ,[NewValue]
        ,[EntryDate]
FROM [Insurance].[dbo].[ClaimLog]
WHERE FieldName = 'ExaminerCode' AND OldValue = 'Unassigned'

SELECT * FROM Insurance.dbo.Users
WHERE UserName = 'dclara' OR Supervisor = 'dclara'

SELECT  ClaimantID
    , ClosedDate
    , ReopenedDate
    , try_convert(float, ClosedDate - ReopenedDate) as DateDifference
FROM [Insurance].[dbo].[Claimant]
WHERE ClosedDate IS NOT NULL

SELECT *
FROM Insurance.dbo.Claimant
WHERE YEAR(ClosedDate) = 2018
  AND ReopenedDate IS NULL
