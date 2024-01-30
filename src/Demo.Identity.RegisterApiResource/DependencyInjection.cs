using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Demo.Identity.Management.Setup;
using Demo.Identity.Management.Options;

namespace Demo.Identity.RegisterApiResource
{
    public static class DependencyInjection
    {
        public static IServiceCollection ServicesSetup(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddTransient<App>();
            services.SetupAuth0ManagementApiClient(configuration);

            services.Configure<ClientCredentials>( configuration.GetSection("client-credentials"));
            services.Configure<ApiServiceInformation>(configuration.GetSection("api-service-information"));
            services.Configure<ApiScopes>(configuration.GetSection("api-scopes"));

            return services;
        }
    }
}
