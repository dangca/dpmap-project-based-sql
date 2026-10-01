SELECT C.ClaimNumber, R.ReserveAmount
    , (
    SELECT SUM(R2.ReserveAmount)
    FROM Reserve R2
    INNER JOIN Claimant Cl2 ON Cl2.ClaimantID = R2.ClaimantID
    INNER JOIN CLaim C2 ON Cl2.ClaimID = C2.ClaimID
    WHERE C2.ClaimNumber = '500008648-1'
    GROUP BY Cl2.ClaimantId
    ) as TotalReserveAmount
FROM Reserve R
INNER JOIN Claimant Cl ON Cl.ClaimantID = R.ClaimantID
INNER JOIN Claim C ON Cl.ClaimID = C.ClaimID
WHERE C.ClaimNumber = '500008648-1'
