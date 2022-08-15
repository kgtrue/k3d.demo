using System.Drawing;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
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

var random = new Random();

app.MapGet("/RandomColor", () =>
{
  var colorARGB = new GetColorARGB
        (
            Color.FromArgb(random.Next(256), random.Next(256), random.Next(256)).ToArgb()
        );
    return colorARGB;
})
.WithName("RandomColor");

app.MapGet("/helth", () => { return DateTime.UtcNow; }).WithName("helth");


app.Run();

internal record GetColorARGB(int argb)
{
}