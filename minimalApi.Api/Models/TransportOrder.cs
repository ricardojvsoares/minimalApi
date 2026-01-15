namespace DashboardCargas.Api.Models;

public record TransportOrder(
    Guid Id,
    string GuideNumber,
    string LicensePlate,
    string ClientName,
    string Product,
    long Quantity,
    string Lot,
    string Origin,
    string Destination,
    DateTime DepartureDate
);