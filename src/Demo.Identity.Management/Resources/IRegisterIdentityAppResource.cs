using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo.Identity.Management.Resources
{
    public interface IRegisterIdentityAppResource
    {
        public Task<bool> RegisterApp();
    }
}
