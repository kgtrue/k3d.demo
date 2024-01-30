using Demo.Identity.Management.Auth0Client;
using Demo.Identity.Management.Resources;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
namespace Demo.Identity.Management.Setup
{
    public static class Auth0DependencyInjection
    {
        public static IServiceCollection SetupAuth0ManagementApiClient(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddHttpClient("Auth0HttpClient");
            services.AddScoped<IRegisterIdentityApiResource, RegisterAuth0IdentityApiResource>();
            return services;
        }

        public static IServiceCollection SetupAuth0ManagementAppClient(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddHttpClient("Auth0HttpClient");
            services.AddScoped<IRegisterIdentityAppResource, RegisterAuth0IdentityAppResource>();
            return services;
        }
    }
}
