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
        private const string BASE_URL_CONFIG_KEY = "DemoApiSecond:BaseUrl";
        private readonly RestSharp.RestClient restClient;
        public DemoApiSecondService(IConfiguration configuration)
        {
            restClient = new RestSharp.RestClient(configuration.GetValue<string>(BASE_URL_CONFIG_KEY));
        }

        public async Task<GetColorARGB> GetRandomARGB()
        {
            try
            {
                var endPoint = "/HostAndColor";
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
