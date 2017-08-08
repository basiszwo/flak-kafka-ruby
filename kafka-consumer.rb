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

consumer = kafka.consumer(group_id: "ruby-consumer")

puts "Establishing connection to Apache Kafka on host #{config['zookeepers'].first} ..."

consumer.subscribe(topic)

puts "Connected to Kafka topic #{topic}"

consumer.each_message do |message|
  print message.topic
  print " - "
  print message.partition
  print " - "
  print message.offset
  print " - "
  print message.key
  print " - "
  puts message.value
end
