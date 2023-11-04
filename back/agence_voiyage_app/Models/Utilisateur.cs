using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using BCrypt.Net;

namespace agence_voiyage_app.Models
{
    public class Utilisateur
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [Column(TypeName = "nvarchar(255)")]
        public string Nom { get; set; } = "";

        [Required]
        [Column(TypeName = "nvarchar(255)")]
        public string Prenom { get; set; } = "";

        public int Age { get; set; }

        [Required]
        [Column(TypeName = "nvarchar(255)")]
        public string Genre { get; set; } = "";

        [Required]
        [Column(TypeName = "nvarchar(255)")]
        public string Image { get; set; } ="";

        [Required]
        [Column(TypeName = "nvarchar(255)")]
        public string Cin { get; set; } = "00000000";

        [Required]
        [Column(TypeName = "nvarchar(255)")]
        public string Num_passeport { get; set; } = "00000000";

        [Required]
        [Column(TypeName = "nvarchar(255)")]
        public string Email { get; set; } = "";

        [Required]
        [Column(TypeName = "nvarchar(255)")]
        public string Password { get; set; } = "";

        [Required]
        [Column(TypeName = "nvarchar(255)")]
        public string Num_tel { get; set; } = "00000000";

    }
}
