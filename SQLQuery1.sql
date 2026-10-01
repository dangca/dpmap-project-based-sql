SELECT DISTINCT ExaminerCode
FROM Insurance.dbo.Claim

SELECT DISTINCT ExaminerCode
    , InjuryState
    , JurisdictionID
    , YEAR(EntryDate) as EntryYear
FROM Insurance.dbo.Claim
GROUP BY ExaminerCode
    , InjuryState
    , JurisdictionID
    , YEAR (EntryDate)

SELECT DISTINCT ExaminerCode
    , COUNT(*) as NumberOfClaimsHandled
FROM Insurance.dbo.Claim
GROUP BY ExaminerCode

SELECT EnteredBy
    , COUNT(*) as NumberOfPublishes
FROM Insurance.dbo.ReservingTool
WHERE IsPulished = 1
GROUP BY EnteredBy

----------

USE Insurance
GO

SELECT C.ClaimNumber, SUM(RT>ExpenseReservingAmount) as ExpensesSum
FROM Claim C
INNER JOIN ReservingTool RT ON C.ClaimNUmber = RT.ClaimNumber
GROUP BY C.ClaimNumber

SELECT C.ClaimNumber, SUM(RT>ExpenseReservingAmount) as ExpensesSum
FROM Claim C, ReservingTool RT
WHERE C.ClaimNUmber = RT.ClaimNumber
GROUP BY C.ClaimNumber

----------

USE Insurance
GO

SELECT U.*
FROM Users U

SELECT C.*, U.LastFirstName as ExaminerFullName
FROM Claim C
JOIN Users U ON U.UserName = C.ExaminerCode
