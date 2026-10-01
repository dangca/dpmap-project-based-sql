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

SELECT Reserve.ClaimantId
    , ReserveType.ReserveTypeDesc as ReserveType
    , Reserve.ReserveAmount
FROM Reserve
INNER JOIN ReeserveType ON Reserve.ReserveTypeID = ReserveType.reserveTypeID

SELECT C.ClaimNumer, CT.ClaimantTypeDesc as ClaimantType
FROM Claim C
INNER JOIN Claimant Clmt ON C.ClaimId = Clmt.ClaimID
INNER JOIN ClaimantType CT ON Clmt.ClaimantTypeID = CT.ClaimantTypeID

SELECT TOP 100 ClaimNumber, CL.*
FROM Claim C
INNER JOIN ClaimLog CL ON C.ClaimId = CL.PK
ORDER BY PK

SELECT Claim C
INNER JOIN ClaimLog CL ON C.ClaimID = CL.PK
ORDER BY PK

SELECT ClaimNumber
FROM Claim
ORDER BY ClaimNumber

SELECT C.ClaimNumber, SUM(RT.ExpenseReservingAmount) as ExpensesSum
FROM Claim C
INNER JOIN ReservingTool RT ON C.ClaimNumber.RT.ClaimNumber
GROUP BY C.ClaimNumber
ORDER BY SUM(RT.ExpenseReservingAmount)

SELECT CS.ClaimStatusDesc, Clmt.CLaimantID, P.MiddleName
FROM Claimant Clmt
INNER JOIN ClaimStatus CS ON CS.ClaimStatusId = Clmt.claimStatusID
INNER JOIN Patient P ON Clmt.PatientId = P.PatientId
WHERE P.MiddleName <> ''

SELECT *
FROM Patient
WHERE MiddleName <> ''

SELECT C.ClaimNumber, COUNT(CL.PK) as LockCount
FROM Claim C
LEFT JOIN ClaimLog CL ON C.CLaimID = CL.PK AND FieldName = 'LockedBy'
WHERE FieldName = 'LockedBy'
GROUP BY C.ClaimNumber
ORDER BY LockCount

SELECT *
FROM ClaimLog
