from fastapi import FastAPI, HTTPException

app = FastAPI()


@app.get("/")
def read_root():
    """Devuelve una breve descripcion del servicio. Cambio aca para probar el workflow"""
    return {
        "description": "Esta es una pequeña API de calculadora. Puedes sumar, restar, multiplicar y dividir dos números usando las rutas /add, /subtract, /multiply y /divide."
    }


@app.get("/add")
def add(a: float, b: float):
    """Suma dos números y devuelve el resultado."""
    return {"resultado": a + b, "mensaje": "La suma se realizó correctamente."}


@app.get("/subtract")
def subtract(a: float, b: float):
    """Resta dos números y devuelve el resultado."""
    return {"resultado": a - b, "mensaje": "La resta se realizó correctamente."}


@app.get("/multiply")
def multiply(a: float, b: float):
    """Multiplica dos números y devuelve el resultado."""
    return {
        "resultado": a * b,
        "mensaje": "La multiplicación se realizó correctamente.",
    }


@app.get("/divide")
def divide(a: float, b: float):
    """Divide dos números y devuelve el resultado. Si b es 0, lanza un error."""
    if b == 0:
        raise HTTPException(status_code=400, detail="No se puede dividir por cero.")
    return {"resultado": a / b, "mensaje": "La división se realizó correctamente."}
