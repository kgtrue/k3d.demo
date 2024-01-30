using Demo.Identity.Management.Options;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Demo.Identity.Management.Setup;
namespace Demo.Identity.RegisterAppResource
{
    public static class DependencyInjection
    {
        public static IServiceCollection ServicesSetup(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddTransient<App>();
            services.SetupAuth0ManagementAppClient(configuration);

            services.Configure<ClientCredentials>(configuration.GetSection("client-credentials"));
            services.Configure<ApiScopes>(configuration.GetSection("api-scopes"));

            return services;
        }
    }
}
