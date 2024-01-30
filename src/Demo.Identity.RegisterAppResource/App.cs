using Demo.Identity.Management.Resources;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo.Identity.RegisterAppResource
{
    public class App
    {
        private readonly IRegisterIdentityAppResource _registerIdentityAppResource;

        public App(IRegisterIdentityAppResource registerIdentityAppResource)
        {
            _registerIdentityAppResource = registerIdentityAppResource;
        }

        public async Task Run(string[] args)
        {
            await _registerIdentityAppResource.RegisterApp();
        }
    }
}
