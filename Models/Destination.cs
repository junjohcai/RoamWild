using Supabase.Postgrest.Attributes;
using Supabase.Postgrest.Models;

namespace MyBlazorApp.Models;

[Table("destinations")]
public class Destination : BaseModel
{
    [PrimaryKey("id", false)]
    public long Id { get; set; }

    [Column("title")]
    public string Title { get; set; } = "";

    [Column("location")]
    public string Location { get; set; } = "";

    [Column("continent")]
    public string Continent { get; set; } = "";

    [Column("badge")]
    public string Badge { get; set; } = "";

    [Column("image")]
    public string Image { get; set; } = "";

    [Column("alt")]
    public string Alt { get; set; } = "";

    [Column("deleted_at")]
    public DateTime? DeletedAt { get; set; }

    [Column("created_at")]
    public DateTime CreatedAt { get; set; }
}
