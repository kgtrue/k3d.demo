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
        private const string BASE_URL_CONFIG_KEY = "DemoApiFirst:BaseUrl";
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
