FROM python:3.11-slim

# Crear usuario no privilegiado
RUN useradd -m -u 1000 appuser

WORKDIR /app

# Instalar dependencias y configurar el entorno
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/* \
    && git init \
    && pip install --no-cache-dir -r requirements.txt

# Copiar todo el repositorio
COPY . .

# Cambiar el propietario de los archivos al usuario no privilegiado
RUN chown -R appuser:appuser /app

# Cambiar al usuario no privilegiado
USER appuser

# Exponer el puerto
EXPOSE 8000

# Comando para ejecutar la aplicación
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload", "--log-level", "debug"] 