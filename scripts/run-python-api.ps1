$ErrorActionPreference = "Stop"
Set-Location (Join-Path $PSScriptRoot "../services/ai-api")
python -m venv .venv
& .\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
uvicorn app:app --reload --port 8000
