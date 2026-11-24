// Starter screen logic. Move into an Android Studio app module to compile.
package org.agrisentinel.mobile

data class FieldReading(
    val zone: String,
    val soilMoisturePercent: Double,
    val temperatureC: Double
)

fun moistureStatus(value: Double): String = when {
    value !in 0.0..100.0 -> "INVALID_READING"
    value < 25.0 -> "REVIEW_IRRIGATION"
    value > 42.0 -> "REVIEW_DRAINAGE"
    else -> "MONITOR"
}
