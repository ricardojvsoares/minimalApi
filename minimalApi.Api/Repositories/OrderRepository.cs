using System.Data;
using Microsoft.Data.SqlClient;
using Dapper;
using DashboardCargas.Api.Models;
using Serilog;

namespace DashboardCargas.Api.Repositories;

public interface IOrderRepository
{
    Task<IEnumerable<TransportOrder>> GetOrdersAsync(DateTime startDate, DateTime endDate);
}

public class OrderRepository : IOrderRepository
{
    private readonly string _connectionString;

    public OrderRepository(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection") ?? string.Empty;
    }

    public async Task<IEnumerable<TransportOrder>> GetOrdersAsync(DateTime startDate, DateTime endDate)
    {
        try
        {
            //Acesso via Dapper e Stored Procedure
            using var connection = new SqlConnection(_connectionString);
            var parameters = new { StartDate = startDate, EndDate = endDate };
            
            Log.Information("Executar SP via Dapper...");
            
            var result = await connection.QueryAsync<TransportOrder>(
                "sp_GetTransportOrders",
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return result.OrderByDescending(o => o.DepartureDate);
        }
        catch (Exception ex)
        {
            //Fallback para dados simulados em caso de falha na BD
            Log.Warning(ex, "Falha na DB. Devolvendo dados simulados da SP conforme o script SQL.");
            return GetMockDataFromSp().Where(o => o.DepartureDate >= startDate && o.DepartureDate <= endDate);
        }
    }

    private IEnumerable<TransportOrder> GetMockDataFromSp()
    {

        var today = DateTime.Now.Date;
        return new List<TransportOrder>
        {
            new (Guid.NewGuid(), "G-2026-0001", "AA-12-BB", "Construções Silva Lda", "Cimento Portland", 25, "LT-001", "Lisboa", "Porto", today.AddHours(8)),
            new (Guid.NewGuid(), "G-2026-0002", "CC-34-DD", "Obras & Projetos SA", "Areia Fina", 40, "LT-002", "Porto", "Braga", today.AddHours(11)),
            new (Guid.NewGuid(), "G-2026-0003", "EE-56-FF", "Ferreira & Filhos", "Brita", 35, "LT-003", "Braga", "Coimbra", today.AddHours(14)),
            new (Guid.NewGuid(), "G-2026-0004", "GG-78-HH", "MegaBuild Lda", "Aço CA-50", 15, "LT-004", "Coimbra", "Faro", today.AddHours(17))
           
        };
    }
}