using Demo.Identity.Management.Resources;
using Auth0.ManagementApi;
using System.Net.Http.Json;
using Auth0.ManagementApi.Models;
using Demo.Identity.Management.Options;
using Microsoft.Extensions.Options;
using System.Collections.Generic;
using System.Linq;
namespace Demo.Identity.Management.Auth0Client
{
    public class RegisterAuth0IdentityApiResource : IRegisterIdentityApiResource
    {

        private readonly HttpClient _httpClient;
        private readonly ClientCredentials _clientCredentials;
        private readonly ApiServiceInformation _apiServiceInformation;
        private readonly ApiScopes _scopes;

        public RegisterAuth0IdentityApiResource(
            IOptions<ClientCredentials> clientCredentials,
            IOptions<ApiServiceInformation> apiServiceInformation,
            IOptions<ApiScopes> scopes,
            IHttpClientFactory httpClient)
        {
            _httpClient = httpClient.CreateClient("Auth0HttpClient");
            _clientCredentials = clientCredentials.Value;
            _apiServiceInformation = apiServiceInformation.Value;
            _scopes = scopes.Value;
        }

        public async Task<bool> RegisterApi()
        {
            try
            {
                var tokenResponse = await _httpClient.PostAsJsonAsync(_clientCredentials.BasePath, new
                {
                    client_id = _clientCredentials.ClientId,
                    client_secret = _clientCredentials.ClientSecret,
                    audience = _clientCredentials.Audience,
                    grant_type = _clientCredentials.GranType
                });

                var accessToken = await tokenResponse.Content.ReadFromJsonAsync<AccessToken>();
                var managementApiClient = new ManagementApiClient(accessToken.Token, new Uri(_clientCredentials.Audience));

                var api = await managementApiClient.ResourceServers.GetAsync(_apiServiceInformation.Identifier) ?? await managementApiClient.ResourceServers.CreateAsync(new ResourceServerCreateRequest
                {
                    Identifier = _apiServiceInformation.Identifier,
                    Name = $"{_apiServiceInformation.Name}-{_apiServiceInformation.Version}"
                });

                if (api == null) return false;

                var updateResult = await managementApiClient.ResourceServers.UpdateAsync(api.Id, new ResourceServerUpdateRequest()
                {
                    Name = $"{_apiServiceInformation.Name}-{_apiServiceInformation.Version}",
                    Scopes = _scopes.Scopes.Select(s => 
                        new ResourceServerScope() { 
                            Value = s.Value,
                            Description = s.Description })
                        .ToList()
                });

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }

        }
    }
}
