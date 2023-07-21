import pika
import os
import hashlib

connection = pika.BlockingConnection(
    pika.ConnectionParameters(
        host="35.184.46.172",
        credentials=pika.PlainCredentials(username="huststudent",
                                          password="password")
        )
)
channel = connection.channel()
channel.exchange_declare(exchange="cache_delete", exchange_type="fanout")
result = channel.queue_declare(queue="", exclusive=True)
queue_name = result.method.queue

channel.queue_bind(exchange="cache_delete", queue=queue_name)


def callback(ch, method, properties, body):
    result = hashlib.md5(body).hexdigest()
    file_path = "/opt/cache_server/cache/{}/{}/{}".format(
        result[-1], result[-3:-1], result
        )
    os.remove(file_path)
    print(file_path)
    print(result)


channel.basic_consume(queue=queue_name,
                      on_message_callback=callback, auto_ack=True)

channel.start_consuming()
