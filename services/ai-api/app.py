from datetime import datetime, timezone
from typing import Literal
from fastapi import FastAPI
from pydantic import BaseModel, Field

app = FastAPI(title="AGRISENTINEL AI & Telemetry API", version="0.1.0")

class Telemetry(BaseModel):
    farm_id: str = "farm-demo"
    zone: str
    soil_moisture: float = Field(ge=0, le=100)
    temperature_c: float = Field(ge=-20, le=70)
    ph: float = Field(ge=0, le=14)

class CropCheck(BaseModel):
    crop: str
    leaf_observation: str

@app.get("/health")
def health():
    return {"status": "ok", "service": "ai-api", "time": datetime.now(timezone.utc).isoformat()}

@app.get("/api/v1/telemetry")
def sample_telemetry():
    return {
        "mode": "sample",
        "readings": [
            {"zone": "north-field", "soil_moisture": 24.5, "temperature_c": 29.2, "ph": 6.4},
            {"zone": "east-field", "soil_moisture": 31.0, "temperature_c": 28.1, "ph": 6.7},
        ],
    }

@app.post("/api/v1/telemetry")
def ingest_telemetry(reading: Telemetry):
    # Starter endpoint: persistence and authentication are intentionally not wired yet.
    return {"accepted": True, "stored": False, "mode": "starter", "reading": reading.model_dump()}

@app.post("/api/v1/crop-check")
def crop_check(request: CropCheck):
    # Educational keyword demo only; never treat this as a crop diagnosis.
    text = request.leaf_observation.lower()
    possible_observation = (
        "yellowing_or_spots" if "yellow" in text or "spot" in text
        else "wilting" if "wilt" in text
        else "observation_recorded"
    )
    return {
        "crop": request.crop,
        "observation_category": possible_observation,
        "result_type": "demo_heuristic_not_a_diagnosis",
        "next_step": "Consult a qualified local agricultural extension professional and provide clear photos plus field context.",
    }
