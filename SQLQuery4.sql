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

----------

USE Insurance
GO

SELECT C.ClaimNumber, P.FirstName, P.MiddleName, P.LastName
FROM Claim C
INNER JOIN CLaimant CL ON C.ClaimID = CL.ClaimID
INNER JOIN Patient P ON CL.PatientId = P.PatientId
WHERE C.CLaimNumber = '752663830-X'

SELECT O.OfficeDesc as Office, COUNT(U.Username) as UserCount
FROM Office O
LEFT JOIN Users U ON O.OfficeID = U.OfficeID
GROUP BY O.OfficeDesc
ORDER BY COUNT(U.Username) DESC

SELECT *
FROM Reserve R
INNER JOIN Users U ON R.EnteredBy = U.UserName
INNER JOIN Office O ON U.OfficeID = O.OfficeID
WHERE O.OfficeDesc = 'San Francisco'

SELECT ISNULL(RT2.ReserveTypeDesc, RT1.ReserveTypeDesc) as ReserveBucket
        , RT2.ReserveTypeDesc AS ReserveParent, RT1.ReserveTypeDesc
        , R.*
FROM Reserve R
INNER JOIN ReserveType RT1 ON R.ReserveTypeID = RT1.reserveTypeID
LEFT JOIN ReserveType RT2 ON RT2.reserveTypeID = RT1.ParentID
