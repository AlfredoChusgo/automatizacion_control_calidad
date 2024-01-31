using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using POO.Application.Common.Interfaces.Persistence;
using POO.Infrastructure.Persistence;
using POO.Infrastructure.Persistence.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Infrastructure
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInfrastructure(this IServiceCollection services)
        {

            //services.AddDbContext<ApplicationDbContext>(
            //    options => options.UseSqlite("Data Source=../POO.Infrastructure/Persistence/app.db")); // to use this is required to apply a migration

            services.AddDbContext<ApplicationDbContext>(
                options => options.UseInMemoryDatabase("app_db"));
            services.AddScoped<IProductoRepository, ProductoRepository>();
            services.AddScoped<DataSeederService>();

            ExecuteSeedData(services);

            return services;
        }

        private static void ExecuteSeedData(IServiceCollection services)
        {
            using (var serviceProvider = services.BuildServiceProvider())
            {
                var dataSeederService = serviceProvider.GetRequiredService<DataSeederService>();
                dataSeederService.SeedData();
            }
        }
    }
}
