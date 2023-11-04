using Microsoft.EntityFrameworkCore;

namespace agence_voiyage_app.Models
{
    public class APIDbContext : DbContext
    {
        public APIDbContext(DbContextOptions option) : base(option)
        { 
        
        }

        public DbSet<Utilisateur> utilisateurs { get; set; }
    }
}
