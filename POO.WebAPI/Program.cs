using Microsoft.EntityFrameworkCore;
using POO.Application;
using POO.Infrastructure;
using POO.Infrastructure.Persistence;

var builder = WebApplication.CreateBuilder(args);

{

    builder.Services        
        .AddApplication()
        .AddInfrastructure();
}
//builder.Services.AddDbContext<ApplicationDbContext>(
//                options => options.UseSqlite("Data Source=app.db", x => x.MigrationsAssembly("POO.WebAPI")));


// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

//app.UseAuthorization();

app.MapControllers();

app.Run();
