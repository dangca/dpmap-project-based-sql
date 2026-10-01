SELECT MAX(PaymentLimit) as MaximumPaymentLimit
    , MIN(PaymentLimit) as MinimumPaymentLimit
    , MIN(ReserveLimit) as MinimumResLimit
    , AVG(ReserveLimit) as AvgResLimit
FROM Insurance.dbo.Users

SELECT
    COUNT(ReopenedDate) as ReopenedCount
    , COUNT(ClosedDate) as ClosedCount
    , COUNT(ClosedDate) - COUNT(ReopenedDate) as ClosedReopenedDifference
FROM Insurance.dbo.Claimant

SELECT AVG(ReserveAmount) as AverageReserveAmount
FROM Insurance.dbo.Reserve

----------

SELECT C.ClaimNumber
FROM 
    (
    SELECT TOP 10 *
    FROM Claim
    ) C

    SELECT Supervisor, UserName
    FROM Users
    WHERE UserName IN (
        SELECT DISTINCT EnteredBy
        FROM ReservingTool
        )

SELECT MedicalReservingAmount, EnteredOn, IsPublished
FROM ReservingTool
WHERE EnteredOn =
    (
    SELECT MAX(EnteredOn)
    FROM ReservingTool
    WHERE IsPublished = 1
    )
    AND IsPublished = 1
