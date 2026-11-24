#include <stdio.h>
#include <stdlib.h>

/* Example frame: "MOISTURE=24.5" — replace stdin with a UART sensor reader. */
int main(void) {
    char frame[] = "MOISTURE=24.5";
    char *value = NULL;
    double moisture;

    value = frame;
    const char prefix[] = "MOISTURE=";
    for (int i = 0; prefix[i] != '\0'; ++i) {
        if (frame[i] != prefix[i]) {
            fprintf(stderr, "Invalid sensor frame\n");
            return 1;
        }
    }
    value = frame + sizeof(prefix) - 1;
    moisture = strtod(value, NULL);

    if (moisture < 0.0 || moisture > 100.0) {
        fprintf(stderr, "Moisture out of range: %.1f\n", moisture);
        return 1;
    }
    printf("{\"sensor\":\"soil-moisture\",\"value\":%.1f,\"unit\":\"percent\"}\n", moisture);
    return 0;
}
