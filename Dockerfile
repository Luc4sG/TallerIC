FROM python:3.11-slim

# Crear usuario no privilegiado
RUN useradd -m -u 1000 appuser

WORKDIR /app

# Instalar dependencias y configurar el entorno
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/* \
    && git init \
    && pip install --no-cache-dir -r requirements.txt \
    && pre-commit install \
    && echo '#!/bin/bash\n\
echo "Herramientas de formateo disponibles:"\n\
echo "1. Formatear todo el proyecto: black ."\n\
echo "2. Formatear un archivo: black <archivo>"\n\
echo "3. Verificar sin modificar: black . --check"\n\
' > /usr/local/bin/format-help \
    && chmod +x /usr/local/bin/format-help

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