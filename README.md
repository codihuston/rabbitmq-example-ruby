# Purpose

Demo an implementation of a RabbitMQ service in a distributed architecture.
This architecture consists of:

1. RabbitMQ Server

   Producers and Receivers will connect to a RabbitMQ to publish/consume
   messages. A RabbitMQ server can host Exchanges, which is responsible
   for routing messages to queues.

2. Producer
3. Receivers

> Note: the messages are currently delivered at a 1:1 basis (default). That is,
> each receiver will receive a unique message (Direct Exchange). It does
> not use a Fanout Exchange.

## TODO

Implement a RabbitMQ using a Work Queue and Fanout Exchange.

## Startup

```bash
docker-compose up --build
```

There appears to be some issues with the producer/receivers running, so
you can run them independently from your container host like so:

> Note: use a unique terminal per service.

```bash
export RABBITMQ_HOST=localhost
export RABBITMQ_VHOST=my_vhost
export RABBITMQ_USER=user
export RABBITMQ_PASS=password
```

Start the service(s):

```bash
docker-compose run --rm producer
docker-compose run --rm receiver_01
docker-compose run --rm receiver_02
docker-compose run --rm receiver_03
```

## Cleanup

```bash
docker-compose down -v
```

## References

1. https://www.rabbitmq.com/tutorials/amqp-concepts.html
2. https://www.rabbitmq.com/tutorials/tutorial-one-ruby.html (direct)
3. https://www.rabbitmq.com/tutorials/tutorial-two-ruby.html (work queues, round robin)
4. https://www.rabbitmq.com/tutorials/tutorial-three-ruby.html (fanout)
