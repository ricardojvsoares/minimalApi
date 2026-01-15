CREATE OR ALTER PROCEDURE sp_GetTransportOrders
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    -- Returns 20 rows: 4 entries per day for the last 5 days (today included)
    SELECT NEWID() AS Id, 'G-2026-0001' AS GuideNumber, 'AA-12-BB' AS LicensePlate, 'Construções Silva Lda' AS ClientName, 'Cimento Portland' AS Product, 25 AS Quantity, 'LT-001' AS Lot, 'Lisboa' AS Origin, 'Porto' AS Destination, DATEADD(hour, 8, CAST(GETDATE() AS DATE)) AS DepartureDate
    UNION ALL
    SELECT NEWID(), 'G-2026-0002', 'CC-34-DD', 'Obras & Projetos SA', 'Areia Fina', 40, 'LT-002', 'Porto', 'Braga', DATEADD(hour, 11, CAST(GETDATE() AS DATE))
    UNION ALL
    SELECT NEWID(), 'G-2026-0003', 'EE-56-FF', 'Ferreira & Filhos', 'Brita', 35, 'LT-003', 'Braga', 'Coimbra', DATEADD(hour, 14, CAST(GETDATE() AS DATE))
    UNION ALL
    SELECT NEWID(), 'G-2026-0004', 'GG-78-HH', 'MegaBuild Lda', 'Aço CA-50', 15, 'LT-004', 'Coimbra', 'Faro', DATEADD(hour, 17, CAST(GETDATE() AS DATE))

    UNION ALL
    SELECT NEWID(), 'G-2026-0005', 'AA-12-BB', 'Construções Silva Lda', 'Cimento Portland', 26, 'LT-005', 'Lisboa', 'Porto', DATEADD(hour, 8, DATEADD(day, -1, CAST(GETDATE() AS DATE)))
    UNION ALL
    SELECT NEWID(), 'G-2026-0006', 'CC-34-DD', 'Obras & Projetos SA', 'Areia Fina', 41, 'LT-006', 'Porto', 'Braga', DATEADD(hour, 11, DATEADD(day, -1, CAST(GETDATE() AS DATE)))
    UNION ALL
    SELECT NEWID(), 'G-2026-0007', 'EE-56-FF', 'Ferreira & Filhos', 'Brita', 36, 'LT-007', 'Braga', 'Coimbra', DATEADD(hour, 14, DATEADD(day, -1, CAST(GETDATE() AS DATE)))
    UNION ALL
    SELECT NEWID(), 'G-2026-0008', 'GG-78-HH', 'MegaBuild Lda', 'Aço CA-50', 16, 'LT-008', 'Coimbra', 'Faro', DATEADD(hour, 17, DATEADD(day, -1, CAST(GETDATE() AS DATE)))

    UNION ALL
    SELECT NEWID(), 'G-2026-0009', 'AA-12-BB', 'Construções Silva Lda', 'Cimento Portland', 27, 'LT-009', 'Lisboa', 'Porto', DATEADD(hour, 8, DATEADD(day, -2, CAST(GETDATE() AS DATE)))
    UNION ALL
    SELECT NEWID(), 'G-2026-0010', 'CC-34-DD', 'Obras & Projetos SA', 'Areia Fina', 42, 'LT-010', 'Porto', 'Braga', DATEADD(hour, 11, DATEADD(day, -2, CAST(GETDATE() AS DATE)))
    UNION ALL
    SELECT NEWID(), 'G-2026-0011', 'EE-56-FF', 'Ferreira & Filhos', 'Brita', 37, 'LT-011', 'Braga', 'Coimbra', DATEADD(hour, 14, DATEADD(day, -2, CAST(GETDATE() AS DATE)))
    UNION ALL
    SELECT NEWID(), 'G-2026-0012', 'GG-78-HH', 'MegaBuild Lda', 'Aço CA-50', 17, 'LT-012', 'Coimbra', 'Faro', DATEADD(hour, 17, DATEADD(day, -2, CAST(GETDATE() AS DATE)))

    UNION ALL
    SELECT NEWID(), 'G-2026-0013', 'AA-12-BB', 'Construções Silva Lda', 'Cimento Portland', 28, 'LT-013', 'Lisboa', 'Porto', DATEADD(hour, 8, DATEADD(day, -3, CAST(GETDATE() AS DATE)))
    UNION ALL
    SELECT NEWID(), 'G-2026-0014', 'CC-34-DD', 'Obras & Projetos SA', 'Areia Fina', 43, 'LT-014', 'Porto', 'Braga', DATEADD(hour, 11, DATEADD(day, -3, CAST(GETDATE() AS DATE)))
    UNION ALL
    SELECT NEWID(), 'G-2026-0015', 'EE-56-FF', 'Ferreira & Filhos', 'Brita', 38, 'LT-015', 'Braga', 'Coimbra', DATEADD(hour, 14, DATEADD(day, -3, CAST(GETDATE() AS DATE)))
    UNION ALL
    SELECT NEWID(), 'G-2026-0016', 'GG-78-HH', 'MegaBuild Lda', 'Aço CA-50', 18, 'LT-016', 'Coimbra', 'Faro', DATEADD(hour, 17, DATEADD(day, -3, CAST(GETDATE() AS DATE)))

    UNION ALL
    SELECT NEWID(), 'G-2026-0017', 'AA-12-BB', 'Construções Silva Lda', 'Cimento Portland', 29, 'LT-017', 'Lisboa', 'Porto', DATEADD(hour, 8, DATEADD(day, -4, CAST(GETDATE() AS DATE)))
    UNION ALL
    SELECT NEWID(), 'G-2026-0018', 'CC-34-DD', 'Obras & Projetos SA', 'Areia Fina', 44, 'LT-018', 'Porto', 'Braga', DATEADD(hour, 11, DATEADD(day, -4, CAST(GETDATE() AS DATE)))
    UNION ALL
    SELECT NEWID(), 'G-2026-0019', 'EE-56-FF', 'Ferreira & Filhos', 'Brita', 39, 'LT-019', 'Braga', 'Coimbra', DATEADD(hour, 14, DATEADD(day, -4, CAST(GETDATE() AS DATE)))
    UNION ALL
    SELECT NEWID(), 'G-2026-0020', 'GG-78-HH', 'MegaBuild Lda', 'Aço CA-50', 19, 'LT-020', 'Coimbra', 'Faro', DATEADD(hour, 17, DATEADD(day, -4, CAST(GETDATE() AS DATE)));
END
GO