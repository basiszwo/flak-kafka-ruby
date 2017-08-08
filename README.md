# FLAK Stack - Ruby Apache Kafka

This repo contains example a consumer and a producer for the Apache Kafka
component of the FLAK Stack designed, defined and implemented in my diploma thesis.

FLAK = Apache Flink + Apacge Accumulo + Apache Kafka


## Usage

Install a ruby with rvm or any other ruby version manager.

Then install bundler and the bundle

```
gem install bundler
bundle install
```

Adjust the configuration by first copying the example yaml file

```
cp config.yml.example config.yml
```

Then adjust the variables `topic` and the list of Apache Zookeeper hosts.


Then run the producer with

```ruby
ruby kafka-producer.rb
```

and the consumer with

```ruby
ruby kafka-consumer.rb
```
