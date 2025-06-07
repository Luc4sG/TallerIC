# Build stage
FROM python:3.11-slim AS builder

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
COPY .pre-commit-config.yaml .
COPY pyproject.toml .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /app/wheels -r requirements.txt

# Final stage
FROM python:3.11-slim

WORKDIR /app

# Create non-root user
RUN useradd -m -u 1000 appuser

# Copy wheels from builder
COPY --from=builder /app/wheels /wheels
COPY --from=builder /app/requirements.txt .
COPY --from=builder /app/.pre-commit-config.yaml .
COPY --from=builder /app/pyproject.toml .

# Install dependencies
RUN pip install --no-cache /wheels/*

# Install pre-commit hooks
RUN pre-commit install

# Create format help script
RUN echo '#!/bin/bash\n\
echo "Herramientas de formateo disponibles:"\n\
echo "1. Formatear todo el proyecto: black ."\n\
echo "2. Formatear un archivo: black <archivo>"\n\
echo "3. Verificar sin modificar: black . --check"\n\
' > /usr/local/bin/format-help && chmod +x /usr/local/bin/format-help

# Copy application code
COPY . .

# Set environment variables
ENV PYTHONPATH=/app
ENV PORT=8000

# Switch to non-root user
USER appuser

# Expose port
EXPOSE 8000

# Run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"] 