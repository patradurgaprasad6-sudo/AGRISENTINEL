enum MoistureStatus { reviewIrrigation, reviewDrainage, monitor, invalid }

MoistureStatus moistureStatus(double value) {
  if (value < 0 || value > 100) return MoistureStatus.invalid;
  if (value < 25) return MoistureStatus.reviewIrrigation;
  if (value > 42) return MoistureStatus.reviewDrainage;
  return MoistureStatus.monitor;
}

class FieldReading {
  final String zone;
  final double soilMoisturePercent;
  const FieldReading(this.zone, this.soilMoisturePercent);
}
