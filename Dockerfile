FROM python:3.11-slim

WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Inicializar git
RUN git init

# Copiar todo el repositorio
COPY . .

# Instalar dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Instalar pre-commit hooks
RUN pre-commit install

# Crear script de ayuda para formateo
RUN echo '#!/bin/bash\n\
echo "Herramientas de formateo disponibles:"\n\
echo "1. Formatear todo el proyecto: black ."\n\
echo "2. Formatear un archivo: black <archivo>"\n\
echo "3. Verificar sin modificar: black . --check"\n\
' > /usr/local/bin/format-help && chmod +x /usr/local/bin/format-help

# Exponer el puerto
EXPOSE 8000

# Comando para ejecutar la aplicación
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload", "--log-level", "debug"] 