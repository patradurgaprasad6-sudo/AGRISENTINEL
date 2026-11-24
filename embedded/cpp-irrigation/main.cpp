#include <iostream>
#include <string>

enum class Decision { Monitor, ReviewIrrigation, ReviewDrainage };

Decision decideIrrigation(double moisturePercent, double dryThreshold = 25.0,
                          double wetThreshold = 42.0) {
    if (moisturePercent < 0.0 || moisturePercent > 100.0)
        throw std::invalid_argument("moisture must be between 0 and 100");
    if (moisturePercent < dryThreshold) return Decision::ReviewIrrigation;
    if (moisturePercent > wetThreshold) return Decision::ReviewDrainage;
    return Decision::Monitor;
}

int main() {
    const double sample = 24.5;
    const auto result = decideIrrigation(sample);
    std::string label = result == Decision::ReviewIrrigation ? "REVIEW_IRRIGATION"
                      : result == Decision::ReviewDrainage ? "REVIEW_DRAINAGE" : "MONITOR";
    std::cout << "Sample moisture: " << sample << "% -> " << label
              << "\nNo actuator is controlled by this program.\n";
}
