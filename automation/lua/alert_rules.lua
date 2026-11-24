-- Small rules example. Feed calibrated sensor readings in production.
local function moisture_alert(moisture_percent)
  assert(type(moisture_percent) == "number", "reading must be numeric")
  assert(moisture_percent >= 0 and moisture_percent <= 100, "reading outside 0..100")
  if moisture_percent < 25 then
    return "REVIEW_IRRIGATION"
  elseif moisture_percent > 42 then
    return "REVIEW_DRAINAGE"
  end
  return "MONITOR"
end

local sample = 24.5
print(string.format("soil_moisture=%.1f%% decision=%s", sample, moisture_alert(sample)))
