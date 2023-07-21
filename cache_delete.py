import pika

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
    print(body)


channel.basic_consume(queue=queue_name,
                      on_message_callback=callback, auto_ack=True)

channel.start_consuming()
