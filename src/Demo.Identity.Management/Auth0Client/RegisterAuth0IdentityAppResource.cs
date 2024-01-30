using Auth0.ManagementApi.Models;
using Auth0.ManagementApi;
using Demo.Identity.Management.Options;
using Demo.Identity.Management.Resources;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Extensions.Options;
using static System.Formats.Asn1.AsnWriter;
using System.Net.Http.Json;

namespace Demo.Identity.Management.Auth0Client
{
    public class RegisterAuth0IdentityAppResource : IRegisterIdentityAppResource
    {
        private readonly ClientCredentials _clientCredentials;
        private readonly AppInformation _appInformation;
        private readonly AppScopes _scopes;
        private readonly HttpClient _httpClient;
       

        public RegisterAuth0IdentityAppResource(
           IOptions<ClientCredentials> clientCredentials,
           IOptions<AppInformation> appInformation,
           IOptions<AppScopes> scopes,
           IHttpClientFactory httpClient)
        {
            _httpClient = httpClient.CreateClient("Auth0HttpClient");
            _clientCredentials = clientCredentials.Value;
            _appInformation = appInformation.Value;
            _scopes = scopes.Value;
        }

        public async Task<bool> RegisterApp()
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

                var resourceServers = await managementApiClient.Clients.CreateAsync(new ClientCreateRequest() { ApplicationType=ClientApplicationType.RegularWeb, Name="gfdfg"});

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
