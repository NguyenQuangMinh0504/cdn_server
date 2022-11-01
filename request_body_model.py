from pydantic import BaseModel, Field


class Origin(BaseModel):
    name: str = Field(example="origin1")
    protocol: str = Field(example="http")
    host: str = Field(example="kenh14cdn.com")
    address: str = Field(example="kenh14cdn.com")


class Domain(BaseModel):
    name: str = Field("kenh14cdn.com")
    origins: list[Origin]

