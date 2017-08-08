require "bundler/setup"
Bundler.require

require 'kafka'
require 'yaml'

config_file = File.join(__dir__, 'config.yml')

unless File.exist?(config_file)
  abort "Please copy config.yml.example to config.yml!!!"
end

config = YAML.load_file(config_file)

kafka = Kafka.new(
  # At least one of these nodes must be available:
  seed_brokers: config['zookeepers'],

  # Set an optional client id in order to identify the client to Kafka:
  client_id: "ruby-kafka"
)

topic = config['topic']

counter = 1

# partitions = kafka.partitions_for(topic)

producer = kafka.producer

loop do
  50.times do
    # write to any partition
    # partition = rand(partitions)

    # Add messages to the producer buffer.
    # producer.produce("Message #{counter}", topic: topic, partition: partition)
    producer.produce("Message #{counter}", topic: topic)

    counter += 1
  end

  producer.deliver_messages

  # If this line fails with Kafka::DeliveryFailed we *may* have succeeded in delivering
  # the message to Kafka but won't know for sure.

  # Deliver the messages to Kafka.
  producer.deliver_messages

  # If we get to this line we can be sure that the message has been delivered to Kafka!
  # sleep 1
end
