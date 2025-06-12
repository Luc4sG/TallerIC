import pytest
from fastapi.testclient import TestClient

from main import app

client = TestClient(app)


def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert "calculator" in response.json()["description"].lower()


def test_add():
    response = client.get("/add?a=3&b=2")
    assert response.status_code == 200
    assert response.json()["resultado"] == 5
    assert "suma" in response.json()["mensaje"].lower()


def test_subtract():
    response = client.get("/subtract?a=5&b=3")
    assert response.status_code == 200
    assert response.json()["resultado"] == 2
    assert "resta" in response.json()["mensaje"].lower()


def test_multiply():
    response = client.get("/multiply?a=4&b=2.5")
    assert response.status_code == 200
    assert response.json()["resultado"] == 10
    assert "multiplicación" in response.json()["mensaje"].lower()


def test_divide():
    response = client.get("/divide?a=10&b=2")
    assert response.status_code == 200
    assert response.json()["resultado"] == 5
    assert "división" in response.json()["mensaje"].lower()


def test_divide_by_zero():
    response = client.get("/divide?a=10&b=0")
    assert response.status_code == 400
    assert "cero" in response.json()["detail"].lower()


def test_unprotected_divide():
    response = client.get("/unprotecteddivide?a=10&b=2")
    assert response.status_code == 200
    assert response.json()["resultado"] == 5
    assert "división" in response.json()["mensaje"].lower()


def test_unprotected_divide_by_zero():
    response = client.get("/unprotecteddivide?a=10&b=0")
    assert (
        response.status_code == 500
    )  # Debería fallar con un error 500 ya que no está protegido
