CREATE OR ALTER PROCEDURE sp_GetTransportOrders
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        NEWID() AS Id, 
        'G-2024-0001' AS GuideNumber, 
        'AA-12-BB' AS LicensePlate, 
        'Construções Silva Lda' AS ClientName, 
        'Cimento Portland' AS Product, 
        25 AS Quantity, 
        'LT-001' AS Lot, 
        'Lisboa' AS Origin, 
        'Porto' AS Destination, 
        GETDATE() AS DepartureDate
    UNION ALL
    SELECT NEWID(), 'G-2024-0002', 'CC-34-DD', 'Obras & Projetos SA', 'Areia Fina', 40, 'LT-002', 'Porto', 'Braga', GETDATE()
    UNION ALL
    SELECT NEWID(), 'G-2024-0003', 'EE-56-FF', 'Ferreira & Filhos', 'Brita', 35, 'LT-003', 'Braga', 'Coimbra', GETDATE()
    UNION ALL
    SELECT NEWID(), 'G-2024-0004', 'GG-78-HH', 'MegaBuild Lda', 'Aço CA-50', 15, 'LT-004', 'Coimbra', 'Faro', GETDATE();
END
GO