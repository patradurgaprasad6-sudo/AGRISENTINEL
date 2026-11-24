var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/health", () => Results.Ok(new {
    status = "ok",
    service = "agrisentinel-dotnet-api",
    note = "Starter service; no persistence configured."
}));

app.MapPost("/api/field-events", (FieldEvent fieldEvent) =>
{
    if (string.IsNullOrWhiteSpace(fieldEvent.Zone) ||
        string.IsNullOrWhiteSpace(fieldEvent.EventType))
        return Results.BadRequest(new { error = "zone and eventType are required" });

    return Results.Accepted(value: new {
        accepted = true,
        persisted = false,
        fieldEvent
    });
});

app.Run();

record FieldEvent(string Zone, string EventType, string? Description);
