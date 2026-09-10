FROM python:3.14-slim

# Define build arguments for metadata
ARG BUILD_DATE
ARG GIT_COMMIT
ARG APP_VERSION
ARG REPO_URL

# Apply OCI standard metadata labels
LABEL org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.revision=$GIT_COMMIT \
      org.opencontainers.image.version=$APP_VERSION \
      org.opencontainers.image.source=$REPO_URL \
      org.opencontainers.image.title="student-ml-api"

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .
COPY VERSION .

EXPOSE 5000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "5000"]