from fastapi import FastAPI
from fastapi.responses import FileResponse

from database import domain_collection, r

from request_body_model import Domain


app = FastAPI()


@app.get("/")
async def main():
    return FileResponse("./images/letroll.png")


@app.post("/domain", description="Register domain to database")
async def add_domain(domain: Domain):
    find_query = {"name": domain.name}
    document = domain_collection.find_one(find_query)
    if document is None:
        domain_collection.insert_one(domain.dict())
        r.set(domain.name, domain.json())
        return {"Register domain success"}
    return {"Domain already existed in database"}
