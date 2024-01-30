using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Demo.Identity.Management.Resources
{
    internal record AccessToken
    {
        [JsonPropertyName("access_token")]
        public string Token { get; set; }
        [JsonPropertyName("expires_in")]
        public long expires_in { get; set; }
        [JsonPropertyName("token_type")]
        public string TokenType { get; set; }
    }
}
