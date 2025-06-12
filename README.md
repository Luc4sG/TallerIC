# TallerIC

[![SonarCloud](https://sonarcloud.io/api/project_badges/measure?project=Luc4sG_TallerIC&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=Luc4sG_TallerIC)
[![Cobertura de Código](https://sonarcloud.io/api/project_badges/measure?project=Luc4sG_TallerIC&metric=coverage)](https://sonarcloud.io/summary/new_code?id=Luc4sG_TallerIC)
[![Calidad de Código](https://sonarcloud.io/api/project_badges/measure?project=Luc4sG_TallerIC&metric=reliability_rating)](https://sonarcloud.io/summary/new_code?id=Luc4sG_TallerIC)
[![Mantenibilidad](https://sonarcloud.io/api/project_badges/measure?project=Luc4sG_TallerIC&metric=sqale_rating)](https://sonarcloud.io/summary/new_code?id=Luc4sG_TallerIC)

## Descripción del Proyecto
![PipelineTallerIC](https://github.com/user-attachments/assets/1a73d0aa-b296-4a1a-b2ab-c5c64061c8df)

Este proyecto implementa un pipeline de Integración Continua (IC) utilizando una API simple desarrollada con FastAPI. El objetivo es demostrar las prácticas y herramientas fundamentales de IC, incluyendo:

- Repositorio de código (GitHub)
- Servidor de IC (GitHub Actions)
- Entorno de desarrollo local
- Pruebas automatizadas
- Análisis de calidad de código (SonarCloud)
- Integración con herramientas de gestión (Trello)
- Notificaciones automáticas (Slack)
- Despliegue continuo

## Componentes del Pipeline

### 1. Repositorio de Código
- GitHub como sistema de control de versiones
- Ramas protegidas (main y develop)
- Convención de nombres para ramas de feature
- Integración con Trello para seguimiento de tareas

### 2. Servidor de Integración Continua
- GitHub Actions como servidor de IC
- Workflows automatizados para:
  - Validación de código
  - Pruebas unitarias
  - Análisis de calidad
  - Despliegue automático

### 3. Entorno de Desarrollo
- Build local con uvicorn
- Pruebas automatizadas con pytest
- Linting con Flake8 y Black
- Análisis de código con SonarCloud

### 4. Pruebas Automatizadas
- Pruebas unitarias para endpoints de la API
- Verificación de cobertura de código
- Validación de calidad y estilo
- Integración con el pipeline de CI

## Flujo de Desarrollo

### Convención de Nombres de Ramas

Todas las ramas de características deben seguir este patrón:
```
feature/[ID_TARJETA_TRELLO]-[DESCRIPCION_CORTA]
```

Ejemplo:
```
feature/GiHaKwki-AutenticacionDeUsuario
```

### Proceso de Pull Request

1. **Creación de Rama**
   - Crear una nueva rama desde `develop` usando la convención de nombres anterior
   - El ID de la tarjeta de Trello en el nombre de la rama es crucial para la automatización

2. **Descripción del PR**
   - La descripción del PR debe incluir el enlace de Trello en uno de estos formatos:
     ```
     https://trello.com/c/[ID_TARJETA]
     [Trello](https://trello.com/c/[ID_TARJETA])
     ```
   - Para PRs de `develop` a `main`, si no se encuentra una tarjeta de Trello, se agregará una sección para URLs manuales de tarjetas

3. **Flujos de Trabajo Automatizados**
   - **Descripción de PR**: Genera automáticamente una descripción basada en la tarjeta de Trello
   - **Pipeline de CI**: Ejecuta pruebas, linting y verificaciones de calidad de código
   - **Integración con Trello**: 
     - Mueve tarjetas a "In Progress" cuando se crea el PR
     - Mueve tarjetas a "Review" cuando el PR se fusiona a develop
     - Mueve tarjetas a "Done" cuando el PR se fusiona a main

### Reglas de Protección de Ramas

- Las ramas `main` y `develop` están protegidas
- Requiere revisiones de PR antes de fusionar
- Requiere que el pipeline de CI pase
- Requiere ramas actualizadas antes de fusionar

### Calidad de Código

- Análisis de SonarCloud en cada PR
- Se aplican requisitos de cobertura de código
- Deben pasar las puertas de calidad
- Se monitorea la calificación de mantenibilidad

### Pruebas Automatizadas

- Se requieren pruebas unitarias para nuevas características
- Pruebas de integración para rutas críticas
- Se monitorea la cobertura de pruebas
- Las pruebas fallidas bloquean la fusión del PR

## Contribución

1. Crear una nueva rama desde `develop` siguiendo la convención de nombres
2. Realizar los cambios
3. Crear un PR con el formato de descripción adecuado
4. Esperar por CI y revisiones
5. Fusionar solo después de la aprobación y que pasen todas las verificaciones

## Mejores Prácticas

- Mantener los PRs enfocados y pequeños
- Incluir pruebas para nuevas características
- Seguir el estilo de código existente
- Actualizar la documentación cuando sea necesario
- Usar mensajes de commit significativos

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
