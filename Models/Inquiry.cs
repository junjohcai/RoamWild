using Supabase.Postgrest.Attributes;
using Supabase.Postgrest.Models;

namespace MyBlazorApp.Models;

[Table("inquiries")]
public class Inquiry : BaseModel
{
    [PrimaryKey("id", false)]
    public long Id { get; set; }

    [Column("destination_id")]
    public long DestinationId { get; set; }

    [Column("destination_title")]
    public string DestinationTitle { get; set; } = "";

    [Column("user_name")]
    public string UserName { get; set; } = "";

    [Column("user_email")]
    public string UserEmail { get; set; } = "";

    [Column("travel_date")]
    public DateTime? TravelDate { get; set; }

    [Column("travellers")]
    public string Travellers { get; set; } = "1 traveller";

    [Column("status")]
    public string Status { get; set; } = "Pending";

    [Column("notes")]
    public string? Notes { get; set; }

    [Column("created_at")]
    public DateTime CreatedAt { get; set; }
}
