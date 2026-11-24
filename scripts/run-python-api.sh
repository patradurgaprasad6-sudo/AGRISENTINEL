#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../services/ai-api"
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app:app --reload --port 8000
