# Getting Started

## Setting up a dev environment
Download a Docker image of Kafka:

`curl -sSL https://raw.githubusercontent.com/bitnami/bitnami-docker-kafka/master/docker-compose.yml > docker-compose.yml`

Run the docker stack

`docker-compose up -d`

You can check if Zookeeper is running:

`telnet localhost 2181` and type `srvr`

SSH into the container with

`docker exec -it kafka-playground_kafka_1 /bin/bash`

note the the container name might be different. Check with `docker ps`

## Create a topic

Run the following command inside the kafka container:

`/opt/bitnami/kafka/bin/kafka-topics.sh --create --bootstrap-server kafka:9092 --topic test`

Note that `kafka` is the DNS of the Kafka service, available via the Docker Network.

## Produce messages

To start a CLI producer run:

`/opt/bitnami/kafka/bin/kafka-console-producer.sh --topic test --bootstrap-server localhost:9092`

Note that you can use `localhost` as the bootstrap server because you are on the kafka broker container.

## Consume messages

While you have a different shell open you can consume the produced commands

`/opt/bitnami/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning`
