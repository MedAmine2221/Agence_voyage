using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using agence_voiyage_app.Models;
using BCrypt.Net;
using NuGet.Protocol.Plugins;
using System.Text;
using System.Net.Mail;
using System.Net;

namespace agence_voiyage_app.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UtilisateursController : ControllerBase
    {
        private readonly APIDbContext _context;

        public UtilisateursController(APIDbContext context)
        {
            _context = context;
        }
        static Random random = new Random();

        static string GenerateRandomPassword()
        {
            const string uppercaseChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            const string digits = "0123456789";
            const string specialChars = "!@#$%^&*()-_=+[]{}|;:'\",.<>?/";

            StringBuilder password = new StringBuilder(8);

            password.Append(uppercaseChars[random.Next(uppercaseChars.Length)]);

            password.Append(digits[random.Next(digits.Length)]);

            password.Append(specialChars[random.Next(specialChars.Length)]);

            for (int i = 3; i < 8; i++)
            {
                string allChars = uppercaseChars + digits + specialChars;
                password.Append(allChars[random.Next(allChars.Length)]);
            }

            for (int i = 0; i < password.Length; i++)
            {
                int j = random.Next(password.Length);
                char temp = password[i];
                password[i] = password[j];
                password[j] = temp;
            }

            return password.ToString();
        }
        private void SendPasswordResetEmail(string email, string newPassword)
        {
            // Configurez les paramètres du serveur SMTP
            var smtpClient = new SmtpClient("smtp.gmail.com")
            {
                Port = 587, // Le port SMTP de votre fournisseur de messagerie
                Credentials = new NetworkCredential("lazregamine258@gmail.com", "sarkznbexeiydxge"),
                EnableSsl = true, // Activez SSL si votre serveur le requiert
            };

            // Créez le message
            var message = new MailMessage();
            message.From = new MailAddress("lazregamine258@gmail.com");
            message.To.Add(email);
            message.Subject = "Réinitialisation de mot de passe";
            message.Body = $"Votre nouveau mot de passe est : {newPassword}";

            try
            {
                // Envoyez l'e-mail
                smtpClient.Send(message);
            }
            catch (Exception ex)
            {
                // Gérez les erreurs d'envoi d'e-mails, par exemple, en journalisant l'erreur
                Console.WriteLine($"Erreur lors de l'envoi de l'e-mail : {ex.Message}");
            }
        }
        /*
        [HttpGet("forgot_password/{email}/{num_passeport}/{cin}")]
        public async Task<IActionResult> ForgotPassword(string email, string cin, string num_passeport)
        {
            var utilisateur = await _context.utilisateurs.FirstOrDefaultAsync(u =>
                u.Email == email &&
                u.Cin == cin &&
                u.Num_passeport == num_passeport);

            if (utilisateur == null)
            {
                return NotFound();
            }

            string newPassword = GenerateRandomPassword();

            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(newPassword);

            utilisateur.Password = hashedPassword;
            _context.Entry(utilisateur).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            SendPasswordResetEmail(email, newPassword);
            return NoContent();
        }*/
        [HttpGet("forgot_password/{email}/{num_passeport}/{cin}")]
        public async Task<IActionResult> ForgotPassword(string email, string cin, string num_passeport)
        {
            var utilisateur = await _context.utilisateurs.FirstOrDefaultAsync(u =>
                u.Email == email &&
                u.Cin == cin &&
                u.Num_passeport == num_passeport);

            if (utilisateur == null)
            {
                return NotFound();
            }

            // Vérifiez si les trois correspondent
            if (utilisateur.Email == email && utilisateur.Cin == cin && utilisateur.Num_passeport == num_passeport)
            {
                string newPassword = GenerateRandomPassword();
                string hashedPassword = BCrypt.Net.BCrypt.HashPassword(newPassword);
                utilisateur.Password = hashedPassword;
                _context.Entry(utilisateur).State = EntityState.Modified;
                await _context.SaveChangesAsync();
                SendPasswordResetEmail(email, newPassword);

                return Ok("Réinitialisation de mot de passe réussie.");
            }
            else
            {
                // Les trois valeurs ne correspondent pas, renvoyez une erreur
                return BadRequest("Les valeurs d'email, Cin et Num_passeport ne correspondent pas à un utilisateur valide.");
            }
        }


        [HttpGet("modify_password/{email}/{currentPassword}/{newPassword}")]
        public async Task<IActionResult> ModifyPassword(string email, string currentPassword, string newPassword)
        {
            // Recherche de l'utilisateur par e-mail
            var utilisateur = await _context.utilisateurs.FirstOrDefaultAsync(u =>
                u.Email == email);

            if (utilisateur == null)
            {
                return NotFound("Utilisateur non trouvé");
            }

            // Vérification du mot de passe actuel
            if (!BCrypt.Net.BCrypt.Verify(currentPassword, utilisateur.Password))
            {
                return BadRequest("Le mot de passe actuel est incorrect");
            }

            // Modification du mot de passe
            string hashedNewPassword = BCrypt.Net.BCrypt.HashPassword(newPassword);
            utilisateur.Password = hashedNewPassword;

            // Mise à jour de l'utilisateur dans la base de données
            _context.Entry(utilisateur).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return Ok("Mot de passe modifié avec succès");
        }

        // GET: api/Utilisateurs
        [HttpGet("all")]
        public async Task<ActionResult<IEnumerable<Utilisateur>>> Getutilisateurs()
        {
          if (_context.utilisateurs == null)
          {
              return NotFound();
          }
            return await _context.utilisateurs.ToListAsync();
        }

        // GET: api/Utilisateurs/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Utilisateur>> GetUtilisateur(int id)
        {
          if (_context.utilisateurs == null)
          {
              return NotFound();
          }
            var utilisateur = await _context.utilisateurs.FindAsync(id);

            if (utilisateur == null)
            {
                return NotFound();
            }

            return utilisateur;
        }

        // PUT: api/Utilisateurs/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        /*[HttpPut("{id}")]
        public async Task<IActionResult> PutUtilisateur(int id, Utilisateur utilisateur)
        {
            if (id != utilisateur.Id)
            {
                return BadRequest();
            }

            _context.Entry(utilisateur).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UtilisateurExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }*/
        [HttpPut("{id}")]
        public async Task<IActionResult> PutUtilisateur(int id, Utilisateur utilisateur)
        {
            if (id != utilisateur.Id)
            {
                return BadRequest();
            }

            // Recherche de l'utilisateur existant dans la base de données
            var existingUser = await _context.utilisateurs.FindAsync(id);

            if (existingUser == null)
            {
                return NotFound();
            }

            // Mettez à jour les propriétés de l'utilisateur, sauf le mot de passe
            existingUser.Nom = utilisateur.Nom;
            existingUser.Prenom = utilisateur.Prenom;
            existingUser.Age = utilisateur.Age;
            existingUser.Genre = utilisateur.Genre;
            existingUser.Image = utilisateur.Image;
            existingUser.Cin = utilisateur.Cin;
            existingUser.Num_passeport = utilisateur.Num_passeport;
            existingUser.Email = utilisateur.Email;
            existingUser.Num_tel = utilisateur.Num_tel;
            // ...

            // Si l'utilisateur souhaite mettre à jour son mot de passe, assurez-vous de le hacher à nouveau
            if (!string.IsNullOrWhiteSpace(utilisateur.Password))
            {
                existingUser.Password = BCrypt.Net.BCrypt.HashPassword(utilisateur.Password);
            }

            // Mettez à jour la base de données
            _context.Entry(existingUser).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return NoContent();
        }

        // POST: api/Utilisateurs
        [HttpPost("register")]
        public async Task<ActionResult<Utilisateur>> PostUtilisateur(Utilisateur utilisateur)
        {
            if (_context.utilisateurs == null)
            {
                return Problem("Entity set 'APIDbContext.utilisateurs' is null.");
            }

            // Hash the user's password
            utilisateur.Password = BCrypt.Net.BCrypt.HashPassword(utilisateur.Password);

            _context.utilisateurs.Add(utilisateur);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetUtilisateur", new { id = utilisateur.Id }, utilisateur);
        }

        // DELETE: api/Utilisateurs/5
        /*[HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUtilisateur(int id)
        {
            if (_context.utilisateurs == null)
            {
                return NotFound();
            }
            var utilisateur = await _context.utilisateurs.FindAsync(id);
            if (utilisateur == null)
            {
                return NotFound();
            }

            _context.utilisateurs.Remove(utilisateur);
            await _context.SaveChangesAsync();

            return NoContent();
        }*/

        /*[HttpPost("login")]
        public IActionResult Login([FromBody] LoginRequest loginRequest)
        {
            var utilisateur = _context.utilisateurs.FirstOrDefault(u => u.Email == loginRequest.Email);

            if (utilisateur == null)
            {
                return Unauthorized(new { message = "E-mail ou mot de passe incorrect" });
            }

            if (BCrypt.Net.BCrypt.Verify(loginRequest.Password, utilisateur.Password))
            {
                // Authentification réussie. Vous pouvez générer un token JWT ici.
                // Retournez le token comme réponse ou stockez-le pour une utilisation ultérieure.
                return Ok(new { message = "Authentification réussie. Vous pouvez maintenant générer un jeton." });
            }

            return Unauthorized(new { message = "E-mail ou mot de passe incorrect" });
        }
        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginRequest loginRequest)
        {
            var utilisateur = _context.utilisateurs.FirstOrDefault(u => u.Email == loginRequest.Email);

            if (utilisateur == null)
            {
                return Unauthorized(new { message = "E-mail ou mot de passe incorrect" });
            }

            if (BCrypt.Net.BCrypt.Verify(loginRequest.Password, utilisateur.Password))
            {
                // Authentification réussie. Vous pouvez maintenant retourner toutes les données de l'utilisateur.
                return Ok(new
                {
                    message = "Authentification réussie",
                    utilisateur = new
                    {
                        utilisateur.Id, 
                        utilisateur.Nom,
                        utilisateur.Prenom,
                        utilisateur.Age, 
                        utilisateur.Num_tel,
                        utilisateur.Num_passeport,
                        utilisateur.Genre,
                        utilisateur.Image,
                        utilisateur.Cin,
                        utilisateur.Email,
                    }
                });
            }

            return Unauthorized(new { message = "E-mail ou mot de passe incorrect" });
        }*/
        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginRequest loginRequest)
        {
            var utilisateur = _context.utilisateurs.FirstOrDefault(u => u.Email == loginRequest.Email);

            if (utilisateur == null)
            {
                return Unauthorized(new { message = "E-mail ou mot de passe incorrect" });
            }

            if (BCrypt.Net.BCrypt.Verify(loginRequest.Password, utilisateur.Password))
            {
                // Authentification réussie. Vous pouvez maintenant retourner toutes les données de l'utilisateur.
                var userResponse = new
                {
                    Id = utilisateur.Id,
                    Nom = utilisateur.Nom,
                    Prenom = utilisateur.Prenom,
                    Age = utilisateur.Age,
                    Num_tel = utilisateur.Num_tel,
                    Num_passeport = utilisateur.Num_passeport,
                    Genre = utilisateur.Genre,
                    Image = utilisateur.Image,
                    Cin = utilisateur.Cin,
                    Email = utilisateur.Email,
                    Password = utilisateur.Password,
                };

                return Ok(userResponse);
            }

            return Unauthorized(new { message = "E-mail ou mot de passe incorrect" });
        }


        private bool UtilisateurExists(int id)
        {
            return (_context.utilisateurs?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
        public class LoginRequest
    {
        public string Email { get; set; }
        public string Password { get; set; }
    }


}