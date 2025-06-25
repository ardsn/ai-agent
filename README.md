# 🤖 AI Agent

Um agente de IA para automação de atendimento de clientes via Whatsapp, desenvolvido em Python com gerenciamento moderno de dependências usando **uv**.

## 📋 Índice

- [Sobre o Projeto](#-sobre-o-projeto)
- [Pré-requisitos](#-pré-requisitos)
- [Instalação](#-instalação)
- [Desenvolvimento](#-desenvolvimento)
- [Comandos Úteis](#-comandos-úteis)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Configuração do Editor](#-configuração-do-editor)
- [Testes](#-testes)
- [Qualidade de Código](#-qualidade-de-código)
- [Contribuição](#-contribuição)
- [Licença](#-licença)

## 🚀 Sobre o Projeto

O AI Agent é um projeto Python moderno que utiliza as melhores práticas de desenvolvimento, incluindo:

- ⚡ **uv** para gerenciamento ultrarrápido de dependências
- 🧪 **pytest** para testes unitários com cobertura de código
- 🎨 **black** para formatação automática de código
- 🔍 **ruff** para linting e análise estática
- 🔒 **mypy** para verificação de tipos estática
- 📦 **hatchling** como build backend

## 🔧 Pré-requisitos

- Python 3.12 ou superior
- uv (gerenciador de dependências)

## 📦 Instalação

### 1. Instalar o uv

O **uv** é um gerenciador de dependências Python extremamente rápido, escrito em Rust:

```bash
# Linux/macOS (recomendado)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Usando pip (alternativa)
pip install uv

# Usando conda
conda install -c conda-forge uv

# Usando homebrew (macOS)
brew install uv
```

### 2. Configurar o projeto

```bash
# Clonar o repositório
git clone https://github.com/seu-usuario/ai-agent.git
cd ai-agent

# Criar ambiente virtual e instalar dependências
uv sync

# Instalar dependências de desenvolvimento
uv sync --dev
```

### 3. Ativar o ambiente virtual (opcional)

```bash
# Linux/macOS
source .venv/bin/activate

# Windows
.venv\Scripts\activate

# Ou usar uv shell (recomendado)
uv shell
```

## 💻 Desenvolvimento

### Primeiros Passos

```bash
# Verificar se tudo está funcionando
make test

# Executar todas as verificações de qualidade
make check

# Ver todos os comandos disponíveis
make help
```

### Gerenciamento de Dependências

```bash
# Adicionar nova dependência de produção
uv add requests
# ou
make add PACKAGE=requests

# Adicionar dependência de desenvolvimento
uv add --dev pytest-mock
# ou
make add-dev PACKAGE=pytest-mock

# Remover dependência
uv remove requests
# ou
make remove PACKAGE=requests

# Atualizar todas as dependências
uv sync --upgrade
# ou
make update

# Ver dependências instaladas
uv pip list
```

## 🛠️ Comandos Úteis

### Comandos Make

| Comando | Descrição |
|---------|-----------|
| `make help` | Mostra todos os comandos disponíveis |
| `make install` | Instala dependências de produção |
| `make dev` | Instala dependências de desenvolvimento |
| `make test` | Executa testes |
| `make test-cov` | Executa testes com relatório de cobertura |
| `make lint` | Executa linting com ruff |
| `make lint-fix` | Corrige problemas de linting automaticamente |
| `make format` | Formata código com black |
| `make format-check` | Verifica formatação sem alterar arquivos |
| `make type-check` | Executa verificação de tipos com mypy |
| `make check` | Executa todas as verificações (format, lint, type) |
| `make clean` | Remove arquivos temporários e cache |
| `make build` | Constrói o pacote para distribuição |
| `make run` | Executa o projeto |
| `make shell` | Abre shell no ambiente virtual |

### Comandos uv Diretos

```bash
# Executar scripts no ambiente virtual
uv run python -m ai_agent
uv run pytest
uv run black src/ tests/
uv run ruff check src/ tests/
uv run mypy src/

# Gerenciar ambiente
uv sync                    # Sincronizar dependências
uv sync --dev             # Incluir dependências de desenvolvimento
uv sync --upgrade         # Atualizar dependências
uv shell                  # Entrar no shell do ambiente virtual

# Informações do projeto
uv pip list               # Listar pacotes instalados
uv pip show package_name  # Mostrar informações de um pacote
```

## 📁 Estrutura do Projeto

```
ai-agent/
├── 📁 src/
│   └── 📁 ai_agent/           # Código fonte principal
│       └── 📄 __init__.py     # Inicialização do pacote
├── 📁 tests/                  # Testes unitários
│   ├── 📄 __init__.py
│   └── 📄 test_example.py     # Testes de exemplo
├── 📁 .vscode/               # Configurações do VS Code/Cursor
│   └── 📄 settings.json
├── 📁 .venv/                 # Ambiente virtual (criado automaticamente)
├── 📄 pyproject.toml         # Configuração do projeto e dependências
├── 📄 uv.lock               # Lock file (versionamento exato das dependências)
├── 📄 .python-version       # Versão do Python para o projeto
├── 📄 Makefile              # Comandos de automação
├── 📄 README.md             # Documentação do projeto
├── 📄 .gitignore            # Arquivos ignorados pelo Git
└── 📄 .coverage             # Relatório de cobertura de testes
```

## ⚙️ Configuração do Editor

### VS Code / Cursor

O projeto inclui configurações otimizadas para VS Code/Cursor em `.vscode/settings.json`:

- ✅ Usa o interpretador Python do ambiente virtual automaticamente
- ✅ Formatação automática com black ao salvar
- ✅ Linting automático com ruff
- ✅ Organização automática de imports
- ✅ Integração com pytest para testes
- ✅ Verificação de tipos com mypy

### Extensões Recomendadas

Para uma melhor experiência de desenvolvimento, instale:

- `ms-python.python` - Suporte oficial ao Python
- `ms-python.black-formatter` - Formatação com black
- `charliermarsh.ruff` - Linting com ruff
- `ms-python.mypy-type-checker` - Verificação de tipos

## 🧪 Testes

### Executar Testes

```bash
# Executar todos os testes
make test
# ou
uv run pytest

# Executar com cobertura detalhada
make test-cov
# ou
uv run pytest --cov=src --cov-report=html

# Executar testes específicos
uv run pytest tests/test_example.py
uv run pytest tests/test_example.py::test_version

# Executar em modo verbose
uv run pytest -v

# Executar com output detalhado
uv run pytest -s
```

### Cobertura de Código

Os relatórios de cobertura são gerados automaticamente:
- **Terminal**: Resumo da cobertura
- **HTML**: Relatório detalhado em `htmlcov/index.html`

```bash
# Ver relatório HTML (após executar tests com cobertura)
open htmlcov/index.html  # macOS
xdg-open htmlcov/index.html  # Linux
```

## 🔍 Qualidade de Código

### Ferramentas Configuradas

#### Black (Formatação)
- Linha máxima: 88 caracteres
- Target: Python 3.12+
- Formatação automática ao salvar (VS Code)

#### Ruff (Linting)
- Regras ativas: E, F, I, N, W, B, C4, UP
- Compatível com flake8, isort, e outras ferramentas
- Correção automática disponível

#### MyPy (Verificação de Tipos)
- Verificação estrita de tipos
- Configurado para Python 3.12+
- Avisos para código não tipado

### Executar Verificações

```bash
# Verificar formatação
make format-check

# Executar linting
make lint

# Verificar tipos
make type-check

# Executar todas as verificações
make check

# Corrigir problemas automaticamente
make format      # Corrige formatação
make lint-fix    # Corrige problemas de linting
```

## 🤝 Contribuição

### Configuração para Contribuição

1. **Fork** o repositório
2. **Clone** seu fork:
   ```bash
   git clone https://github.com/seu-usuario/ai-agent.git
   cd ai-agent
   ```

3. **Configure o ambiente**:
   ```bash
   uv sync --dev
   ```

4. **Crie uma branch** para sua feature:
   ```bash
   git checkout -b feature/nova-funcionalidade
   ```

### Workflow de Desenvolvimento

1. **Desenvolva** sua funcionalidade
2. **Escreva testes** para sua funcionalidade
3. **Execute as verificações**:
   ```bash
   make check  # Formatação, linting, tipos
   make test   # Testes unitários
   ```
4. **Commit suas mudanças**:
   ```bash
   git add .
   git commit -m "feat: adiciona nova funcionalidade"
   ```
5. **Push para sua branch**:
   ```bash
   git push origin feature/nova-funcionalidade
   ```
6. **Abra um Pull Request**

### Padrões de Commit

Use [Conventional Commits](https://conventionalcommits.org/):

```
feat: adiciona nova funcionalidade
fix: corrige bug específico
docs: atualiza documentação
style: mudanças de formatação
refactor: refatoração de código
test: adiciona ou modifica testes
chore: tarefas de manutenção
```

### Checklist para Pull Requests

- [ ] Código formatado com black
- [ ] Linting passando sem erros
- [ ] Verificação de tipos passando
- [ ] Testes unitários escritos e passando
- [ ] Cobertura de código mantida ou melhorada
- [ ] Documentação atualizada se necessário

## 📈 Roadmap

- [ ] Implementar funcionalidades básicas do agente
- [ ] Adicionar integração com APIs de IA
- [ ] Criar interface CLI
- [ ] Adicionar suporte a plugins
- [ ] Implementar dashboard web
- [ ] Adicionar documentação com Sphinx

## 🐛 Relatando Bugs

Para reportar bugs, abra uma [issue](https://github.com/seu-usuario/ai-agent/issues) incluindo:

1. **Descrição** clara do problema
2. **Passos** para reproduzir
3. **Comportamento esperado** vs **comportamento atual**
4. **Ambiente** (OS, versão do Python, versão do uv)
5. **Logs** ou mensagens de erro

## 📄 Licença

Este projeto está licenciado sob a **MIT License**. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## 🙏 Agradecimentos

- [uv](https://docs.astral.sh/uv/) - Gerenciador de dependências ultrarrápido
- [Ruff](https://docs.astral.sh/ruff/) - Linter Python extremamente rápido
- [Black](https://black.readthedocs.io/) - Formatador de código Python
- [pytest](https://docs.pytest.org/) - Framework de testes Python

---

<div align="center">

**⭐ Se este projeto foi útil, considere dar uma estrela!**

</div>
