SELECT C.ClaimNumber, R.ReserveAmount, ReserveSum.TotalReserveAmount
    , R.ReserveAmount/TotalReserveAmount as ReserveProportion
FROM (
    SELECT Cl2.CLaimantID, SUM(R2.ReserveAmount) AS TotalReserveAmount
    FROM Reserve R2
    INNER JOIN Claimant Cl2 ON Cl2.ClaimantID = R2.ClaimantID
    INNER JOIN CLaim C2 ON Cl2.ClaimID = C2.ClaimID
    WHERE C2.ClaimNumber = '500008648-1'
    GROUP BY Cl2.ClaimantId
    ) ReserveSum
INNER JOIN Reserve R ON ReserveSum.ClaimantID = R.ClaimantId
INNER JOIN Claimant Cl ON Cl.ClaimantID = R.ClaimantID
INNER JOIN Claim C ON Cl.ClaimID = C.ClaimID
WHERE C.ClaimNumber = '500008648-1'

SELECT C.ClaimNumber
    , R.ReserveAmount
    , SUM(ReserveAmount) OVER (Partition By C.ClaimNumber) as TotalReserveSum
FROM Reserve R
INNER JOIN Claimant Cl ON Cl.ClaimantID = R.ClaimantID
INNER JOIN Claim C ON Cl.CLaimID = C.ClaimID
WHERE C.ClaimNumber = '500008648-1'

SELECT CL.PK as ClaimID
    , CL.NewValue as CurrentExaminer
    , x.LatestAssignedDate as AssignedDate
FROM (
    SELECT PK, MAX(EntryDate) as LatestAssignedDate
    FROM ClaimLog
    WHERE FieldName = 'ExaminerCode'
    GROUP BY PK
    ) X
INNER JOIN ClaimLog CL ON x.PK = CL.PK AND x.LatestAssignedDate = CL.EntryDate AND CL.FieldName = 'ExaminerCode'
ORDER BY CL.PK
