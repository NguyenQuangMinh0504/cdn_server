from redis import Redis
import json
redis_table = Redis(host="34.28.133.140", port=6379, db=1)
print(redis_table.keys())
redis_table.set("saugau.com",
                json.dumps({"host": "saugau.com", "ip": "104.154.99.60:80"}),
                ex=86400)
print(redis_table.get("saugau.com"))