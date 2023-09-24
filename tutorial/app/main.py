from typing import Union

from fastapi import FastAPI

# Get an instance of FastAPI, called app
app = FastAPI()

@app.get("/")
def read_root():
    """
    Default fastapi endpoint, hit with localhost:8000/
    returns: {"Hello": "World"}
    """
    return {"Hello": "World"}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    """
    More interesting endpoint, where localhost:8000/items/5?q=test would return {item_id: 5, q: test}
    :param item_id: int identifier for item, passed in as path param
    :param q: string to return, passed in as query param
    :returns: {"item_id": item_id, "q": q}
    """
    return {"item_id": item_id, "q": q}