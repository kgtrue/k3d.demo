using System.Net.Sockets;
using System.Net;
using System.Xml.Linq;
using Demo.Api.First.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddScoped<IDemoApiSecondService, DemoApiSecondService>();
var app = builder.Build();

// Configure the HTTP request pipeline.
// Configure the HTTP request pipeline.
//if (app.Environment.IsDevelopment())
//{
    app.UseSwagger();
    app.UseSwaggerUI();
//}

//app.UseHttpsRedirection();

var host = Dns.GetHostName();
var ip = Dns.GetHostEntry(host).AddressList.FirstOrDefault(x => x.AddressFamily == AddressFamily.InterNetwork);

app.MapGet("/HostAndColor", async (IDemoApiSecondService demoApiSecondService) =>
{
    var argb = await demoApiSecondService.GetRandomARGB();
    return new GetHostAndColor
      (
          host,
          ip.ToString(),
          argb.argb
      );
})
.WithName("HostAndColor");

app.MapGet("/helth", () => { return DateTime.UtcNow; }).WithName("helth");
app.MapGet("/foo", () => { return "Bar"; }).WithName("foo");

app.Run();

internal record GetHostAndColor(string hostname, string ip, int color)
{

}
