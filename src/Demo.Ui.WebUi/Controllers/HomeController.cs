using Demo.Api.First.Services;
using Demo.Ui.WebUi.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace Demo.Ui.WebUi.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IDemoApiFirstService demoApiFirstService;

        public HomeController(
            ILogger<HomeController> logger,
            IDemoApiFirstService demoApiFirstService)
        {
            _logger = logger;
            this.demoApiFirstService = demoApiFirstService;
        }

        public async Task<IActionResult> Index()
        {
            var model = await demoApiFirstService.GetHostAndColor();
            return View(model);
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}