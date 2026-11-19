using MyBlazorApp.Components;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

// Supabase registration (Milestone Step 4)
var supabaseUrl = builder.Configuration["Supabase:Url"] ?? "";
var supabaseKey = builder.Configuration["Supabase:Key"] ?? "";

var supabaseOptions = new Supabase.SupabaseOptions
{
    AutoConnectRealtime = false
};

var supabaseClient = new Supabase.Client(
    string.IsNullOrWhiteSpace(supabaseUrl) ? "https://placeholder.supabase.co" : supabaseUrl,
    string.IsNullOrWhiteSpace(supabaseKey) ? "placeholder" : supabaseKey,
    supabaseOptions
);

if (!string.IsNullOrWhiteSpace(supabaseUrl) &&
    !string.IsNullOrWhiteSpace(supabaseKey) &&
    !supabaseUrl.Contains("YOUR-PROJECT-REF") &&
    !supabaseUrl.Contains("YOUR-REF"))
{
    try
    {
        await supabaseClient.InitializeAsync();
    }
    catch (Exception ex)
    {
        Console.WriteLine($"[Supabase] Warning during initialization: {ex.Message}");
    }
}

builder.Services.AddSingleton(supabaseClient);

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();
app.UseAntiforgery();

app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();

