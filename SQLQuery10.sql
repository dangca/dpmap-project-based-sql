WHERE ReserveAmount > (
  SELECT AVG(ReserveAmount)
  FROM Reserve
  )

-- ex 3
SELECT *
FROM Reserve
WHERE ReserveAmount =
    (
    SELECT MIN(ReserveAmount)
    FROM
        (
        SELECT TOP 2 ReserveAmount
        FROM Reserve
        ORDER BY ReserveAmount DESC
        ) X
    )

-- ex 4
SELECT sub.*, RT1.MedicalReservingAmount as FirstMedicalAmount, RT2.MedicalReservingAmount as LastMedicalAmount
FROM
(
SELECT ClaimNumber
    , MIN(EnteredOn) OVER (Partition By ClaimNumber) as FirstPublishDate
    , MAX(EnteredOn) OVER (Partition By ClaimNumber) as LastPublishDate
FROM ReservingTool
WHERE IsPublished = 1
) sub
INNER JOIN ReservingTool RT1 ON RT1.ClaimNumber = sub.ClaimNumber AND RT1.EnteredOn = sub.FirstPublishDate AND RT1.IsPublished = 1
INNER JOIN ReservingTool RT2 ON RT2.ClaimNumber = sub.ClaimNumber AND RT2.EnteredOn = sub.lASTPublishDate AND RT2.IsPublished = 1
ORDER BY ClaimNumber
