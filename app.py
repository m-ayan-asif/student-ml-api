from fastapi import FastAPI
from pydantic import BaseModel

with open("VERSION") as f:
    VERSION = f.read().strip()

app = FastAPI()


class PredictRequest(BaseModel):
    value: float


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/health")
async def health():
    return {
        "status": "healthy",
        "application": "student-ml-api",
        "application_version": VERSION,
        "model_version": "model-1"
        
    }

@app.post("/predict")
async def predict(req: PredictRequest):
    prediction = req.value * 2
    return {"input": req.value, "prediction": prediction}