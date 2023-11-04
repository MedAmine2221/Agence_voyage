using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace agence_voiyage_app.Migrations
{
    /// <inheritdoc />
    public partial class initialcreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "utilisateurs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Nom = table.Column<string>(type: "nvarchar(255)", nullable: false),
                    Prenom = table.Column<string>(type: "nvarchar(255)", nullable: false),
                    Age = table.Column<int>(type: "int", nullable: false),
                    Genre = table.Column<string>(type: "nvarchar(255)", nullable: false),
                    Image = table.Column<string>(type: "nvarchar(255)", nullable: false),
                    Cin = table.Column<string>(type: "nvarchar(255)", nullable: false),
                    Num_passeport = table.Column<string>(type: "nvarchar(255)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(255)", nullable: false),
                    Password = table.Column<string>(type: "nvarchar(255)", nullable: false),
                    Num_tel = table.Column<string>(type: "nvarchar(255)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_utilisateurs", x => x.Id);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "utilisateurs");
        }
    }
}
