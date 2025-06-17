from tools import retrieve, create_appointment
from langchain_core.vectorstores import InMemoryVectorStore
from langchain_community.agent_toolkits import SQLDatabaseToolkit
from langchain.chat_models import init_chat_model
from langgraph.prebuilt import create_react_agent
from langgraph.checkpoint.memory import MemorySaver
from langchain_community.utilities import SQLDatabase
from langchain_huggingface import HuggingFaceEmbeddings



db = SQLDatabase.from_uri("sqlite:///Chinook.db")
embeddings = HuggingFaceEmbeddings(
    model_name="sentence-transformers/all-mpnet-base-v2"
)
vector_store = InMemoryVectorStore(embeddings)
llm = init_chat_model("claude-3-5-sonnet-latest", model_provider="anthropic")
memory = MemorySaver()
toolkit = SQLDatabaseToolkit(db=db, llm=llm)

# TODO: update system message
system_message = """
Você é um agente que atua como um atendende de um estabelecimento,
capaz de responder a dúvidas de clientes, consultar dias e
horários disponíveis e realizar agendamento de atendimentos
quando necessário.

# Instruções para responder dúvidas sobre o estabelecimento

Use a tool `retrieve` para buscar informações no banco vetorial.

# Instruções para consulta de dias e horários disponíveis

Para checar dias e horários disponíveis para agendamentos, interaja
com o banco de dados SQL. Para fazer uma consulta, crie uma query
sintaticamente correta em {dialect} e veja os resultados da query.
A menos que o usuário especifique um número específico de exemplos
que deseja obter, sempre limite sua query a no máximo {top_k} resultados.

Você pode ordenar os resultados por uma coluna relevante para retornar os
exemplos mais interessantes no banco de dados. Nunca faça uma consulta para
todos as colunas de uma tabela específica, apenas busque pelas colunas
relevantes.

Você deve verificar sua query antes de executá-la. Se você receber um erro
ao executar uma query, reescreva a query e tente novamente.

Não faça nenhuma declaração DML (INSERT, UPDATE, DELETE, DROP etc.) no banco
de dados.

Para começar, você deve sempre olhar para as tabelas no banco de dados para
ver o que você pode consultar. Não pule este passo.

Então você deve consultar o esquema das tabelas mais relevantes.

# Instruções para realizar agendamento

Quando for realizar um agendamento, você deve ter como input
o nome do cliente, o dia e o horário do agendamento.

use a tool `create_appointment`.

""".format(
    dialect="SQLite",
    top_k=5,
)


tools = toolkit.get_tools() + [retrieve]

agent_executor = create_react_agent(llm, tools, prompt=system_message, checkpointer=memory)

# Specify an ID for the thread
config = {"configurable": {"thread_id": "abc123"}}

# TODO: remove this
question = "Which country's customers spent the most?"

# TODO: update this
for step in agent_executor.stream(
    {"messages": [{"role": "user", "content": question}]},
    stream_mode="values",
    config=config,
):
    step["messages"][-1].pretty_print()