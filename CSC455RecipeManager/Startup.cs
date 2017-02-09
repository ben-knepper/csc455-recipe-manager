using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(CSC455RecipeManager.Startup))]
namespace CSC455RecipeManager
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
