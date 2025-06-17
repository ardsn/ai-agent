from langchain_core.tools import tool
import httpx

# TODO: review this tool
@tool(response_format="content_and_artifact")
def retrieve(vector_store, query: str):
    """Retrieve information related to a query."""
    retrieved_docs = vector_store.similarity_search(query, k=2)
    serialized = "\n\n".join(
        (f"Source: {doc.metadata}\n" f"Content: {doc.page_content}")
        for doc in retrieved_docs
    )
    return serialized, retrieved_docs


def create_appointment(name: str, date: str, time: str):
    """Create an appointment."""
    url = "http://localhost:8000/api/appointments"
    payload = {
        "name": name,
        "date": date,
        "time": time
    }
    response = httpx.post(url, json=payload)
    return response.json()