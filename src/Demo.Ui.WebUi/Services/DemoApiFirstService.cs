using RestSharp;

namespace Demo.Api.First.Services
{
    public interface IDemoApiFirstService
    {
        public Task<HostAndColor> GetHostAndColor();
    }

    public record HostAndColor(string hostname, string ip, int color)
    {

    }

    public class DemoApiFirstService : IDemoApiFirstService
    {
        private string BASE_URL_CONFIG_KEY = $"http://{Environment.GetEnvironmentVariable("DEMO_API_FIRST_SERVICE_HOST")}:{Environment.GetEnvironmentVariable("DEMO_API_FIRST_SERVICE_PORT")}";
        private readonly RestSharp.RestClient restClient;
        public DemoApiFirstService(IConfiguration configuration)
        {
            restClient = new RestSharp.RestClient(configuration.GetValue<string>(BASE_URL_CONFIG_KEY));
        }

        public async Task<HostAndColor> GetHostAndColor()
        {
            try
            {
                var endPoint = "/RandomColor";
                var request = new RestSharp.RestRequest(endPoint);
                var response = await restClient.ExecuteAsync<HostAndColor>(request);

                if (response.IsSuccessful)
                {
                    return response.Data;
                }

                throw new Exception(response.ErrorMessage);
                
            }
            catch (Exception x)
            {
                throw;
            }
        }
    }
}
