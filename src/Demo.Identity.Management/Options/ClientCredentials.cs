using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo.Identity.Management.Options
{
    public record ClientCredentials()
    {
        public string BasePath { get; init; }
        public string ClientId { get; init; }
        public string ClientSecret { get; init; }
        public string Audience { get; init; }
        public string GranType { get; init; }
    }
}
