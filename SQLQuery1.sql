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
