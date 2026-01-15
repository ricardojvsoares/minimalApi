using Asp.Versioning;
using Serilog;
using DashboardCargas.Api.Models;
using DashboardCargas.Api.Repositories;

var builder = WebApplication.CreateBuilder(args);

// Serilog para ficheiros (Bónus)
Log.Logger = new LoggerConfiguration()
    .WriteTo.Console()
    .WriteTo.File("logs/api-log.txt", rollingInterval: RollingInterval.Day)
    .CreateLogger();
builder.Host.UseSerilog();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddScoped<IOrderRepository, OrderRepository>();

// Versionamento dinâmico via URL: /api/v1/
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

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(options => {
        foreach (var desc in app.DescribeApiVersions())
            options.SwaggerEndpoint($"/swagger/{desc.GroupName}/swagger.json", desc.GroupName.ToUpperInvariant());
    });
}

var versionSet = app.NewApiVersionSet().HasApiVersion(new ApiVersion(1, 0)).Build();

// Endpoint Versionado com DI
app.MapGet("api/v{version:apiVersion}/orders", async (
    DateTime startDate, DateTime endDate, IOrderRepository repository) =>
{
    var orders = await repository.GetOrdersAsync(startDate, endDate);
    return Results.Ok(orders);
})
.WithApiVersionSet(versionSet)
.WithOpenApi();

app.Run();