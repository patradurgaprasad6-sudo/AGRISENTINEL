CREATE TABLE farms (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE sensor_readings (
    id BIGSERIAL PRIMARY KEY,
    farm_id TEXT NOT NULL REFERENCES farms(id),
    zone TEXT NOT NULL,
    soil_moisture_pct NUMERIC(5,2) CHECK (soil_moisture_pct BETWEEN 0 AND 100),
    temperature_c NUMERIC(5,2),
    soil_ph NUMERIC(4,2) CHECK (soil_ph BETWEEN 0 AND 14),
    recorded_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_sensor_readings_farm_time
    ON sensor_readings (farm_id, recorded_at DESC);

CREATE TABLE field_events (
    id BIGSERIAL PRIMARY KEY,
    farm_id TEXT NOT NULL REFERENCES farms(id),
    zone TEXT NOT NULL,
    event_type TEXT NOT NULL,
    description TEXT,
    status TEXT NOT NULL DEFAULT 'open',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO farms (id, name)
VALUES ('farm-demo', 'AGRISENTINEL Demonstration Farm')
ON CONFLICT (id) DO NOTHING;
