from pymongo import MongoClient
import redis


# Using redis to save info for faster


# ----------------- Connect to Mongodb -------------------
client = MongoClient('mongodb://localhost:27017/')
database = client["cdn_server_db"]
domain_collection = database["domain"]
origin_collection = database["origin"]
# ----------------- Redis --------------------------------
r = redis.Redis(host="127.0.0.1", port=6379)
