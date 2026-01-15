using System.Data;
using Microsoft.Data.SqlClient;
using Dapper;
using Asp.Versioning;
using Serilog;
using DashboardCargas.Api.Models;

var builder = WebApplication.CreateBuilder(args);

// Configuração do Serilog
Log.Logger = new LoggerConfiguration()
    .WriteTo.Console()
    .WriteTo.File("logs/log-.txt", rollingInterval: RollingInterval.Day)
    .CreateLogger();
builder.Host.UseSerilog();

// Injeção de Dependências e Swagger
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Configuração de Versionamento
builder.Services.AddApiVersioning(options => {
    options.DefaultApiVersion = new ApiVersion(1, 0);
    options.AssumeDefaultVersionWhenUnspecified = true;
    options.ReportApiVersions = true;
    options.ApiVersionReader = new UrlSegmentApiVersionReader();
}).AddApiExplorer(options => {
    options.GroupNameFormat = "'v'VVV";
    options.SubstituteApiVersionInUrl = true;
});

var app = builder.Build();

// Pipeline de Desenvolvimento
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(options => {
        var descriptions = app.DescribeApiVersions();
        foreach (var desc in descriptions)
            options.SwaggerEndpoint($"/swagger/{desc.GroupName}/swagger.json", desc.GroupName.ToUpperInvariant());
    });
}

// Conjunto de versões para as rotas
var versionSet = app.NewApiVersionSet()
    .HasApiVersion(new ApiVersion(1, 0))
    .Build();

// ENDPOINT: api/v1/orders
app.MapGet("api/v{version:apiVersion}/orders", async (
    DateTime startDate, 
    DateTime endDate, 
    IConfiguration config) => 
{
    try 
    {
        using IDbConnection db = new SqlConnection(config.GetConnectionString("DefaultConnection"));
        
        var parameters = new { StartDate = startDate, EndDate = endDate };
        
        var orders = await db.QueryAsync<TransportOrder>(
            "sp_GetTransportOrders", 
            parameters, 
            commandType: CommandType.StoredProcedure
        );

        return Results.Ok(orders);
    }
    catch (Exception ex) 
    {
        Log.Error(ex, "Erro ao obter cargas");
        return Results.Problem("Erro interno no servidor.");
    }
})
.WithApiVersionSet(versionSet)
.WithName("GetOrdersV1");

app.Run();