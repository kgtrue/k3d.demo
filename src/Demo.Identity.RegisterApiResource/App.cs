using Demo.Identity.Management.Resources;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo.Identity.RegisterApiResource
{
    public class App
    {
        private readonly IRegisterIdentityApiResource _registerIdentityApiResource;

        public App(IRegisterIdentityApiResource registerIdentityApiResource)
        {
           _registerIdentityApiResource = registerIdentityApiResource;
        }

        public async Task Run(string[] args)
        {
            await _registerIdentityApiResource.RegisterApi();
        }
    }
}
