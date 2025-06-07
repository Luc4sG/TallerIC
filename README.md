# FastAPI Hello World with CI/CD Pipeline

[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=Luc4sG_TallerIC&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=Luc4sG_TallerIC)

Este proyecto es una aplicación simple de FastAPI con un pipeline completo de CI/CD que incluye:
- Integración con Trello y Slack
- Validación de nombres de ramas
- Linting y pruebas automáticas
- Análisis de código con SonarQube
- Despliegue automático a Render

## Configuración

### Secrets de GitHub

Necesitarás configurar los siguientes secrets en tu repositorio de GitHub:

- `TRELLO_TOKEN`: Token de API de Trello
- `TRELLO_KEY`: Key de API de Trello
- `TRELLO_IN_PROGRESS_LIST_ID`: ID de la lista "In Progress" en Trello
- `SLACK_WEBHOOK_URL`: URL del webhook de Slack
- `SONAR_TOKEN`: Token de SonarQube
- `SONAR_HOST_URL`: URL de tu instancia de SonarQube
- `RENDER_API_KEY`: API Key de Render
- `RENDER_SERVICE_ID`: ID del servicio en Render

### Convención de Nombres de Ramas

Las ramas de feature deben seguir el formato:
```
feature/CARD_ID-descripcion
```
Donde `CARD_ID` es el ID corto de la tarjeta de Trello.

## Desarrollo Local

1. Clona el repositorio
2. Instala las dependencias:
   ```bash
   pip install -r requirements.txt
   ```
3. Ejecuta la aplicación:
   ```bash
   uvicorn main:app --reload
   ```

## Pipeline de CI/CD

El pipeline incluye los siguientes workflows:

1. **Branch Validation**: Valida el nombre de la rama y actualiza el estado en Trello
2. **Linting**: Ejecuta Flake8 y Black
3. **Testing**: Ejecuta las pruebas con pytest
4. **SonarQube**: Realiza análisis de código en pull requests
5. **Deploy**: Despliega la aplicación a Render cuando se hace merge a main

## Notificaciones

- Se envían notificaciones a Slack para:
  - Creación de nuevas ramas
  - Fallos en linting
  - Fallos en pruebas
  - Fallos en análisis de SonarQube
  - Fallos y éxitos en despliegue

# TallerIC

## Configuración del Entorno de Desarrollo

### 1. Crear y Activar Entorno Virtual

```bash
# Crear entorno virtual
python -m venv venv

# Activar entorno virtual
# En Windows:
.\venv\Scripts\activate
# En Linux/Mac:
source venv/bin/activate
```

### 2. Instalar Dependencias

```bash
# Instalar dependencias del proyecto
pip install -r requirements.txt

# Instalar herramientas de desarrollo
pip install pre-commit flake8 flake8-docstrings isort
```

### 3. Configurar Pre-commit Hooks

```bash
# Instalar hooks de pre-commit
pre-commit install

# Verificar que los hooks funcionan
pre-commit run --all-files
```

### 4. Comandos Útiles

```bash
# Formatear código
black .

# Ordenar imports
isort .

# Verificar linting
flake8 .

# Verificar todo antes de commit
pre-commit run --all-files
```

### 5. Flujo de Trabajo

1. Activar el entorno virtual
2. Hacer cambios en el código
3. Formatear con black e isort
4. Verificar con flake8
5. Hacer commit (los hooks se ejecutarán automáticamente)

### 6. Solución de Problemas

Si encuentras errores al ejecutar pre-commit:

1. Verificar que el entorno virtual está activado
2. Verificar que todas las dependencias están instaladas
3. Reinstalar los hooks:
```bash
pre-commit uninstall
pre-commit install
```

### 7. Notas Importantes

- Siempre trabaja dentro del entorno virtual
- Los hooks de pre-commit se ejecutarán automáticamente al hacer commit
- Si los hooks fallan, el commit será rechazado hasta que corrijas los errores
- Puedes formatear manualmente con `black .` e `isort .` en cualquier momento 