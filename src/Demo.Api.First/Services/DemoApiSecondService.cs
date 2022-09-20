using RestSharp;

namespace Demo.Api.First.Services
{
    public interface IDemoApiSecondService
    {
        public Task<GetColorARGB> GetRandomARGB();
    }

    public record GetColorARGB(int argb)
    {
    }

    public class DemoApiSecondService : IDemoApiSecondService
    {        
        private string BASE_URL_CONFIG_KEY = $"http://{Environment.GetEnvironmentVariable($"{Environment.GetEnvironmentVariable("RELEASE_NAME")?.ToUpper().Replace("-", "_")}_DEMO_API_SECOND_SERVICE_HOST")}:{Environment.GetEnvironmentVariable($"{Environment.GetEnvironmentVariable("RELEASE_NAME")?.ToUpper().Replace("-", "_")}_DEMO_API_SECOND_SERVICE_PORT")}";
        private readonly RestSharp.RestClient restClient;
        public DemoApiSecondService(IConfiguration configuration)
        {
            restClient = new RestSharp.RestClient(BASE_URL_CONFIG_KEY);
        }

        public async Task<GetColorARGB> GetRandomARGB()
        {
            try
            {
                var endPoint = "/RandomColor";
                var request = new RestSharp.RestRequest(endPoint);
                var response = await restClient.ExecuteAsync<GetColorARGB>(request);

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
