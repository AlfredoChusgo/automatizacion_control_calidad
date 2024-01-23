using POO.Application;
using POO.Infrastructure;

var builder = WebApplication.CreateBuilder(args);
{

    builder.Services        
        .AddApplication()
        .AddInfrastructure();
}

// Add services to the container.
builder.Services.AddControllers();
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
app.MapControllers();
app.Run();
