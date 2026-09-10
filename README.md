# student-ml-api: Advanced MLOps CI/CD Workflow

This repository demonstrates a production-ready MLOps CI/CD pipeline. It features a FastAPI-based machine learning inference service, professional Git workflows, automated testing, and container registry publishing via GitHub Actions.

## 🚀 Project Overview

The core application is a simple prediction API (`student-ml-api`) built with FastAPI. 

**Endpoints:**
* `GET /health` — Returns application status, name, and semantic version.
* `POST /predict` — Accepts a JSON payload (`{"value": <number>}`) and returns a mathematical prediction.

## 🛠️ Local Development & Testing

* **Framework:** FastAPI
* **Dependency Management:** `uv`
* **Testing:** `pytest` (Includes 4 automated tests validating successful predictions, health checks, missing inputs, and invalid inputs).
* **Run locally:** `uv run uvicorn app:app --reload`
* **Run tests:** `uv run pytest -v`

## 🔄 Professional Git Workflow

Development on this repository follows strict branch protection and Pull Request (PR) policies:
1. **No Direct Commits:** Direct development on the `main` branch is disabled.
2. **Feature Branches:** All development occurs on isolated feature branches (e.g., `feature/prediction-api`).
3. **Pull Requests:** Code is merged into `main` exclusively through formally documented PRs.
4. **Automated Checks:** GitHub Actions CI must pass successfully before a merge is permitted.

## 🏗️ Continuous Integration (CI)

The CI pipeline (`.github/workflows/ci.yml`) is triggered automatically on every Pull Request targeting the `main` branch. 
* **Test Job:** Sets up Python, installs dependencies, and runs the `pytest` suite.
* **Docker Build Check:** Validates that the application can be successfully containerized. It builds the Docker image to ensure no syntax or dependency errors exist, but does *not* push the image to the registry.

## 📦 Containerization & Caching (Docker)

The application is fully containerized using a production-oriented `Dockerfile`.
* **Optimized Layer Caching:** Dependencies (`requirements.txt`) are copied and installed *before* the application code (`app.py`). This ensures that the heavy `pip install` layer remains cached during standard code changes, making subsequent builds nearly instantaneous.
* **Security & Best Practices:** Uses a specific slim base image (`python:3.14-slim`), avoids running as root where applicable, sets explicit working directories, and utilizes a `.dockerignore` file to keep the image lightweight.

## 🚀 Continuous Delivery (Release Pipeline)

The Release pipeline (`.github/workflows/release.yml`) executes exclusively when a semantic version tag (e.g., `v1.0.0`) is pushed to the repository.
1. **Validates:** Runs the test suite one final time.
2. **Authenticates:** Logs into the GitHub Container Registry (GHCR) securely using repository secrets.
3. **Builds & Tags:** Builds the Docker image and tags it with three identifiers:
   * The semantic version (e.g., `1.1.0`)
   * `latest`
   * The Git Commit SHA (for absolute traceability)
4. **Injects Metadata:** Attaches OCI standard labels to the image (Build Date, Git Commit, App Version, Repository URL) via `--build-arg`.
5. **Publishes:** Pushes the versioned, immutable artifact to GHCR.

## ⏪ Rollback & Traceability

Because the application is packaged as an immutable Docker artifact and stored in a container registry, rolling back to previous versions is instantaneous and reliable. 

Every deployed image can be fully traced back to its exact source code state using the Git Commit SHA tag and the embedded OCI metadata labels.