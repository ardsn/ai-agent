"""
Testes de exemplo para o projeto ai-agent.
"""

from ai_agent import __version__


def test_version():
    """Testa se a versão está definida corretamente."""
    assert __version__ == "0.1.0"


def test_example():
    """Teste de exemplo simples."""
    assert 1 + 1 == 2


def test_example_with_fixture():
    """Teste de exemplo usando fixture."""
    data = {"name": "AI Agent", "version": "0.1.0"}
    assert data["name"] == "AI Agent"
    assert data["version"] == "0.1.0"
