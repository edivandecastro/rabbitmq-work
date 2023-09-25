require 'bunny'
require 'json'

class Publisher
  class << self
    def publish(exchange, message = {}, routing_key)
      x = channel.direct(exchange, durable: true)
      x.publish(message.to_json, :routing_key => routing_key)
    end

    def channel
      @channel ||= connection.create_channel
    end

    def connection
      @connection ||= Bunny.new("amqp://rabbitmq:rabbitmq@localhost:5672").tap(&:start)
    end
  end
end

(1..1000000).each do |i|
  Publisher.publish('download_process', { "mensagem" => "hello world number #{i}" }, "downloads")
end
