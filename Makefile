.PHONY: install dev test lint format type-check clean help

# Variáveis
PYTHON_VERSION = 3.9
SRC_DIR = src
TEST_DIR = tests

# Cores para output
GREEN = \033[0;32m
YELLOW = \033[1;33m
RED = \033[0;31m
NC = \033[0m # No Color

help: ## Mostra esta mensagem de ajuda
	@echo "$(GREEN)Comandos disponíveis:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(YELLOW)%-20s$(NC) %s\n", $$1, $$2}'

install: ## Instala dependências do projeto
	@echo "$(GREEN)Instalando dependências...$(NC)"
	uv sync

dev: ## Instala dependências de desenvolvimento
	@echo "$(GREEN)Instalando dependências de desenvolvimento...$(NC)"
	uv sync --dev

test: ## Executa os testes
	@echo "$(GREEN)Executando testes...$(NC)"
	uv run pytest $(TEST_DIR) -v

test-cov: ## Executa testes com cobertura
	@echo "$(GREEN)Executando testes com cobertura...$(NC)"
	uv run pytest $(TEST_DIR) --cov=$(SRC_DIR) --cov-report=term-missing --cov-report=html

lint: ## Executa linting com ruff
	@echo "$(GREEN)Executando linting...$(NC)"
	uv run ruff check $(SRC_DIR) $(TEST_DIR)

lint-fix: ## Corrige problemas de linting automaticamente
	@echo "$(GREEN)Corrigindo problemas de linting...$(NC)"
	uv run ruff check --fix $(SRC_DIR) $(TEST_DIR)

format: ## Formata o código com black
	@echo "$(GREEN)Formatando código...$(NC)"
	uv run black $(SRC_DIR) $(TEST_DIR)

format-check: ## Verifica formatação sem alterar arquivos
	@echo "$(GREEN)Verificando formatação...$(NC)"
	uv run black --check $(SRC_DIR) $(TEST_DIR)

type-check: ## Executa verificação de tipos com mypy
	@echo "$(GREEN)Verificando tipos...$(NC)"
	uv run mypy $(SRC_DIR)

check: format-check lint type-check ## Executa todas as verificações
	@echo "$(GREEN)Todas as verificações concluídas!$(NC)"

clean: ## Remove arquivos temporários e cache
	@echo "$(GREEN)Limpando arquivos temporários...$(NC)"
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".ruff_cache" -exec rm -rf {} +
	find . -type d -name ".mypy_cache" -exec rm -rf {} +
	rm -rf htmlcov/
	rm -rf dist/
	rm -rf build/

add: ## Adiciona uma nova dependência (uso: make add PACKAGE=nome_do_pacote)
	@if [ -z "$(PACKAGE)" ]; then \
		echo "$(RED)Erro: Especifique o pacote com PACKAGE=nome_do_pacote$(NC)"; \
		exit 1; \
	fi
	@echo "$(GREEN)Adicionando $(PACKAGE)...$(NC)"
	uv add $(PACKAGE)

add-dev: ## Adiciona uma dependência de desenvolvimento (uso: make add-dev PACKAGE=nome_do_pacote)
	@if [ -z "$(PACKAGE)" ]; then \
		echo "$(RED)Erro: Especifique o pacote com PACKAGE=nome_do_pacote$(NC)"; \
		exit 1; \
	fi
	@echo "$(GREEN)Adicionando $(PACKAGE) como dependência de desenvolvimento...$(NC)"
	uv add --dev $(PACKAGE)

remove: ## Remove uma dependência (uso: make remove PACKAGE=nome_do_pacote)
	@if [ -z "$(PACKAGE)" ]; then \
		echo "$(RED)Erro: Especifique o pacote com PACKAGE=nome_do_pacote$(NC)"; \
		exit 1; \
	fi
	@echo "$(GREEN)Removendo $(PACKAGE)...$(NC)"
	uv remove $(PACKAGE)

update: ## Atualiza todas as dependências
	@echo "$(GREEN)Atualizando dependências...$(NC)"
	uv sync --upgrade

build: ## Constrói o pacote
	@echo "$(GREEN)Construindo pacote...$(NC)"
	uv build

run: ## Executa o projeto (personalize conforme necessário)
	@echo "$(GREEN)Executando projeto...$(NC)"
	uv run python -m ai_agent

shell: ## Abre shell no ambiente virtual
	@echo "$(GREEN)Abrindo shell no ambiente virtual...$(NC)"
	uv shell 