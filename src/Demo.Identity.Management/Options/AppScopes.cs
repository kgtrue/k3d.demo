using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo.Identity.Management.Options
{
    public record AppScope()
    {
        public string Value { get; init; }
        public string Description { get; init; }
    }

    public record AppScopes()
    {
        public IEnumerable<AppScope> Scopes { get; init; }
    }
}
