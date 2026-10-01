--Step 2
SELECT *
FROM
(
SELECT
    C.ClaimNumber
    , R.ReserveAmount
    , O.OfficeDesc
    , U.UserName as ExaminerCode
    , Users2.UserName as SupervisorCode
    , Users3.UserName as ManagerCode
    , U.Title as ExaminerTitle
    , Users2.Title as SupervisorTitle
    , Users3.Title as ManagerTitle
    , U.LastFirstName as ExaminerName
    , Users2.LastFirstName as SupervisorName
    , Users3.LastFirstName as ManagerName
    , CS.ClaimStatusDesc
    , P.LastName + ', ' + TRIM(P.FirstName + ' ' + P.MiddleName) as ClaimantName
    , C1.ReopenedDate
    , CT.ClaimantTypeDesc
    , O.State
    , U.ReserveLimit
    , (CASE 
        WHEN RT.ParentId IN (1, 2, 3, 4, 5) THEN RT.ParentID
        ELSE RT.reserveTypeID
        END) AS ReserveCostID
FROM Claimant CL
INNER JOIN Claim C ON C.ClaimID = C1.ClaimID
INNER JOIN Users U ON U.UserName = C.ExaminerCode
INNER JOIN Users Users2 ON U.Supervisor = users2.UserName
INNER JOIN Users Users3 ON Users2.Supervisor = users3.UserName
INNER JOIN Office O ON U.OfficeID = O.OfficeID
INNER JOIN ClaimantType CT ON CT.ClaimantTypeID = C1.ClaimantTypeID
INNER JOIN Reserve R ON R.ClaimantID = Cl.ClaimantID
LEFT JOIN ClaimStatus CS ON CS.ClaimStatusId = CL.claimStatusID
LEFT JOIN ReserveType RT ON RT.reserveTypeID = R.ReserveTypeID
LEFT JOIN Patient P ON P.PatientId = CL.PatientID
WHERE O.OfficeDesc IN ('Sacramento', 'San Francisco', 'San Diego')
    AND (RT.ParentID IN (1, 2, 3, 4, 5) or rt.reserveTypeID IN (1, 2, 3, 4, 5))
    AND (CS.ClaimStatusID = 1 OR (CS.ClaimStatusID = 2 AND CL.ReopenedReasonID <> 3))
) BaseData
PIVOT
(SUM(ReserveAmount)
    FOR ReserveTypeBucketID IN ([1], [2], [3], [4], [5])
) PivotTable
WHERE PivotTable.ClaimantTypeDesct IN ('First Aid', 'Medical Only')
    OR
        (PivotTable.Office = 'San Diego'
            AND ISNULL([1], 0) + ISNULL([2], 0) + ISNULL([3], 0)
                + ISNULL([4], 0) + ISNULL([5], 0) >= PivotTable.ReserveLimit)
    OR
        (PivotTable.Office IN ('Sacramento' , 'San Francisco')
            AND (ISNULL([1], 0) > 800
                OR ISNULL([5], 0) > 100
                OR (ISNULL([2], 0) + ISNULL([3], 0) +ISNULL([4], 0) > 0)
                )
        )
