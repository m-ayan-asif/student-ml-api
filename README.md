# student-ml-api

A simple ML inference API built with FastAPI, demonstrating a professional MLOps CI/CD workflow:
Pull Requests → GitHub Actions CI → Docker → Container Registry.

## Endpoints

- `GET /health` — service health check
- `POST /predict` — accepts `{"value": <number>}`, returns a prediction

## Local Development

```bash
uv sync
uv run uvicorn app:app --reload
```

## Running Tests

```bash
uv run pytest -v
```

