# 🤖 AI Agent

Um agente de IA inteligente para atendimento ao cliente e agendamento de serviços, desenvolvido em Python com LangChain e LangGraph. O agente é capaz de responder dúvidas, consultar disponibilidade e realizar agendamentos de forma automatizada.

## 📋 Índice

- [Sobre o Projeto](#-sobre-o-projeto)
- [Funcionalidades](#-funcionalidades)
- [Arquitetura](#-arquitetura)
- [Pré-requisitos](#-pré-requisitos)
- [Configuração](#-configuração)
- [Instalação](#-instalação)
- [Uso](#-uso)
- [Desenvolvimento](#-desenvolvimento)
- [Comandos Úteis](#-comandos-úteis)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Configuração do Editor](#-configuração-do-editor)
- [Testes](#-testes)
- [Qualidade de Código](#-qualidade-de-código)
- [Troubleshooting](#-troubleshooting)
- [Contribuição](#-contribuição)
- [Licença](#-licença)

## 🚀 Sobre o Projeto

O AI Agent é um assistente virtual inteligente que utiliza as mais recentes tecnologias de IA para automatizar o atendimento ao cliente. O projeto utiliza:

- ⚡ **LangChain** para orquestração de LLMs e ferramentas
- 🧠 **LangGraph** para criação de agentes com memória e estado
- 🔧 **Google Gemini 2.0 Flash** como modelo de linguagem principal
- 🗄️ **SQLite** para consultas de banco de dados
- ⚡ **uv** para gerenciamento ultrarrápido de dependências
- 🧪 **pytest** para testes unitários com cobertura de código
- 🎨 **black** para formatação automática de código
- 🔍 **ruff** para linting e análise estática
- 🔒 **mypy** para verificação de tipos estática
- 📦 **hatchling** como build backend

## 🎯 Funcionalidades

### Atendimento ao Cliente
- **Resposta a dúvidas gerais** sobre o estabelecimento
- **Consulta de informações** usando sistema de recuperação de documentos
- **Interação natural** em português brasileiro

### Agendamento de Serviços
- **Consulta de disponibilidade** de dias e horários
- **Verificação de agenda** em tempo real
- **Criação de agendamentos** com validação automática
- **Gestão de clientes** e profissionais

### Recursos Técnicos
- **Memória persistente** para manter contexto entre conversas
- **Integração com banco de dados** para consultas SQL
- **Ferramentas customizáveis** para diferentes funcionalidades
- **Streaming de respostas** para melhor experiência do usuário

## 🏗️ Arquitetura

O agente utiliza uma arquitetura baseada em **LangGraph** com os seguintes componentes:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   User Input    │───▶│  React Agent    │───▶│   LLM (Gemini)  │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                              │
                              ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Memory        │◀───│   Tools         │───▶│   Database      │
│   (Checkpoint)  │    │   - SQL         │    │   (SQLite)      │
└─────────────────┘    │   - Retrieve    │    └─────────────────┘
                       │   - Appointment │
                       └─────────────────┘
```

### Componentes Principais

- **React Agent**: Orquestra a conversa e decide quais ferramentas usar
- **LLM (Gemini 2.0 Flash)**: Processa linguagem natural e gera respostas
- **Tools**: Ferramentas especializadas (SQL, recuperação, agendamento)
- **Memory**: Mantém contexto entre interações
- **Database**: Armazena dados de clientes, serviços e agendamentos

## 🔧 Pré-requisitos

- Python 3.12 ou superior
- uv (gerenciador de dependências)
- Chave de API do Google (para Gemini)
- Banco de dados SQLite configurado

## ⚙️ Configuração

### 1. Configurar API Keys

O projeto requer uma chave de API do Google para usar o modelo Gemini:

```bash
# Definir variável de ambiente
export GOOGLE_API_KEY="sua_chave_api_aqui"

# Ou adicionar ao arquivo .env (recomendado)
echo "GOOGLE_API_KEY=sua_chave_api_aqui" > .env
```

**⚠️ Importante**: Nunca commite sua chave de API no repositório. Use variáveis de ambiente ou arquivos `.env` (que devem estar no `.gitignore`).

### 2. Configurar Banco de Dados

O agente está configurado para usar um banco SQLite. Você pode:

- Usar o banco existente em `db.sqlite3`
- Criar um novo banco SQLite
- Modificar a configuração para usar outro banco de dados

```python
# Em src/ai_agent/graph.py
db = SQLDatabase.from_uri("sqlite:///caminho/para/seu/banco.sqlite3")
```

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

## 🚀 Uso

### Executar o Agente

```bash
# Executar o agente interativamente
make run
# ou
uv run python -m ai_agent

# Executar diretamente o arquivo graph.py
uv run python src/ai_agent/graph.py
```

### Exemplos de Uso

O agente pode responder a perguntas como:

```
Você: "Quais são os horários disponíveis para hoje?"
Você: "Gostaria de agendar um corte de cabelo para amanhã às 14h"
Você: "Quais serviços vocês oferecem?"
Você: "Preciso cancelar meu agendamento"
```

### Configuração de Thread

O agente mantém memória entre conversas usando threads. Cada thread tem um ID único:

```python
# Em src/ai_agent/graph.py
config = {"configurable": {"thread_id": "abc123"}}
```

Para diferentes usuários ou sessões, use IDs diferentes.

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
│       ├── 📄 __init__.py     # Inicialização do pacote
│       └── 📄 graph.py        # Agente principal com LangGraph
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
├── 📄 db.sqlite3            # Banco de dados SQLite
└── 📄 .coverage             # Relatório de cobertura de testes
```

### Arquivos Principais

- **`src/ai_agent/graph.py`**: Implementação principal do agente com LangGraph
- **`pyproject.toml`**: Configuração do projeto e dependências
- **`Makefile`**: Comandos de automação para desenvolvimento
- **`db.sqlite3`**: Banco de dados com dados de clientes e agendamentos

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

## 🔧 Troubleshooting

### Problemas Comuns

#### 1. Erro de API Key
```
Error: Invalid API key or quota exceeded
```
**Solução**: Verifique se a variável `GOOGLE_API_KEY` está configurada corretamente.

#### 2. Erro de Dependências
```
ModuleNotFoundError: No module named 'langchain'
```
**Solução**: Execute `uv sync` para instalar todas as dependências.

#### 3. Erro de Banco de Dados
```
OperationalError: no such table
```
**Solução**: Verifique se o arquivo `db.sqlite3` existe e tem as tabelas necessárias.

#### 4. Erro de Modelo não Suporta Tools
```
ollama._types.ResponseError: model does not support tools
```
**Solução**: Use modelos que suportem tools (como Gemini, GPT-4) ou implemente um wrapper manual.

### Logs e Debug

Para debug mais detalhado, você pode:

```python
# Adicionar logs no código
import logging
logging.basicConfig(level=logging.DEBUG)

# Ou usar o modo verbose do agente
for step in agent_executor.stream(
    {"messages": [{"role": "user", "content": user_input}]},
    stream_mode="debug",  # Modo debug
    config=config,
):
    print(step)
```

### Verificação de Configuração

```bash
# Verificar se o ambiente está configurado corretamente
make check

# Verificar dependências instaladas
uv pip list

# Testar conexão com a API
uv run python -c "import os; print('API Key:', 'OK' if os.getenv('GOOGLE_API_KEY') else 'MISSING')"
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
- [ ] API keys não expostas no código

## 📈 Roadmap

- [x] Implementar agente básico com LangGraph
- [x] Integração com Google Gemini
- [x] Sistema de ferramentas (tools)
- [x] Memória persistente entre conversas
- [ ] Implementar sistema de recuperação de documentos
- [ ] Adicionar interface CLI mais robusta
- [ ] Criar dashboard web
- [ ] Adicionar suporte a múltiplos idiomas
- [ ] Implementar sistema de plugins
- [ ] Adicionar autenticação de usuários
- [ ] Criar documentação com Sphinx
- [ ] Adicionar testes de integração
- [ ] Implementar sistema de logs estruturados

## 🐛 Relatando Bugs

Para reportar bugs, abra uma [issue](https://github.com/seu-usuario/ai-agent/issues) incluindo:

1. **Descrição** clara do problema
2. **Passos** para reproduzir
3. **Comportamento esperado** vs **comportamento atual**
4. **Ambiente** (OS, versão do Python, versão do uv)
5. **Logs** ou mensagens de erro
6. **Configuração** (API keys, banco de dados, etc.)

## 📄 Licença

Este projeto está licenciado sob a **MIT License**. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## 🙏 Agradecimentos

- [LangChain](https://python.langchain.com/) - Framework para aplicações LLM
- [LangGraph](https://langchain-ai.github.io/langgraph/) - Criação de agentes com estado
- [Google Gemini](https://ai.google.dev/) - Modelo de linguagem avançado
- [uv](https://docs.astral.sh/uv/) - Gerenciador de dependências ultrarrápido
- [Ruff](https://docs.astral.sh/ruff/) - Linter Python extremamente rápido
- [Black](https://black.readthedocs.io/) - Formatador de código Python
- [pytest](https://docs.pytest.org/) - Framework de testes Python

---

<div align="center">

**⭐ Se este projeto foi útil, considere dar uma estrela!**

</div>