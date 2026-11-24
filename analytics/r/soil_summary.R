# Example analytics using sample values only.
soil_moisture <- data.frame(
  zone = c("north-field", "east-field", "south-field", "west-field"),
  moisture_percent = c(24.5, 31.0, 19.8, 38.2)
)

cat("AGRISENTINEL soil moisture summary\n")
print(summary(soil_moisture$moisture_percent))
cat("\nZones below the example 25% review threshold:\n")
print(subset(soil_moisture, moisture_percent < 25))
