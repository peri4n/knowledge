# Getting Started

Download a Docker image of Kafka:

`curl -sSL https://raw.githubusercontent.com/bitnami/bitnami-docker-kafka/master/docker-compose.yml > docker-compose.yml`

Run the docker stack

`docker-compose up -d`

You can check if Zookeeper is running:

`telnet localhost 2181` and type `srvr`

SSH into the container with

`docker exec -it kafka-playground_kafka_1 /bin/bash`

note the the container name might be different. Check with `docker ps`

Create a topic with

`/opt/bitnami/kafka/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 1 --topic test`

Note that `zookeeper` is the DNS of the Zookeeper service, available via the Docker Network.

Produce messages

`/opt/bitnami/kafka/bin/kafka-console-producer.sh --topic test --bootstrap-server localhost:9092`

Consume messages

`/opt/bitnami/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning`
