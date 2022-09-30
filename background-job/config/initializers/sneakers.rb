# frozen_string_literal: true

require 'sneakers/metrics/logging_metrics'

Sneakers.configure(
  amqp:      'amqp://rabbitmq:rabbitmq@localhost:5672', # Connection with RabbitMQ
  metrics:   Sneakers::Metrics::LoggingMetrics.new,     # A metrics provider implementation
  workers:   4,                                         # Number of per-cpu processes to run
  threads:   5,                                         # Threadpool size (good to match prefetch)
  prefetch:  5,                                         # Grab 5 jobs together. Better speed.
  durable:   true,                                      # Is queue durable?
  ack:       true,                                      # Must we acknowledge?
  heartbeat: 2,                                         # Keep a good connection with broker
  env:       'development')                             # Environment

Sneakers.logger = Rails.logger
Sneakers.logger.level = Logger::INFO
