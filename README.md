# FastAPI Hello World with CI/CD Pipeline

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