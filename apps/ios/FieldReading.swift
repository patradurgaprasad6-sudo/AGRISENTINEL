import Foundation

enum MoistureStatus: String {
    case reviewIrrigation = "REVIEW_IRRIGATION"
    case reviewDrainage = "REVIEW_DRAINAGE"
    case monitor = "MONITOR"
    case invalid = "INVALID_READING"
}

func moistureStatus(_ value: Double) -> MoistureStatus {
    guard (0.0...100.0).contains(value) else { return .invalid }
    if value < 25.0 { return .reviewIrrigation }
    if value > 42.0 { return .reviewDrainage }
    return .monitor
}

struct FieldReading: Codable {
    let zone: String
    let soilMoisturePercent: Double
}
