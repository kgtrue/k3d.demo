using System.Net.Sockets;
using System.Net;
using System.Xml.Linq;

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

var summaries = new[]
{
    "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
};

var host = Dns.GetHostName();
var ip = Dns.GetHostEntry(host).AddressList.FirstOrDefault(x => x.AddressFamily == AddressFamily.InterNetwork);

app.MapGet("/HostAndColor", () =>
{
    return new GetHostAndColor
      (
          host,
          ip.ToString(),
          System.Drawing.Color.Red.ToArgb()
      );
})
.WithName("HostAndColor");

app.MapGet("/helth", () => { return DateTime.UtcNow; }).WithName("helth");

app.Run();

internal record GetHostAndColor(string hostname, string ip, int color)
{
    
}
