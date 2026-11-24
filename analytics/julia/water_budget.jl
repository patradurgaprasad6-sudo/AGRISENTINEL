# Estimate irrigation water volume. This is a planning calculation, not an actuator command.
function irrigation_volume_liters(area_m2::Float64, target_depth_mm::Float64, efficiency::Float64=0.8)
    area_m2 > 0 || error("area must be positive")
    target_depth_mm >= 0 || error("depth cannot be negative")
    0 < efficiency <= 1 || error("efficiency must be in (0, 1]")
    # 1 mm over 1 m² equals 1 litre.
    return area_m2 * target_depth_mm / efficiency
end

volume = irrigation_volume_liters(500.0, 5.0, 0.8)
println("Estimated gross irrigation volume: $(round(volume, digits=1)) L")
println("Planning estimate only; verify soil, crop, weather and local agronomy.")
