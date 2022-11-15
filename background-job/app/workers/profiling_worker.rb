require 'sneakers/handlers/maxretry'

class ProfilingWorker
  include Sneakers::Worker

  from_queue 'downloads',
             exchange: 'download_process',
             handler: Sneakers::Handlers::Maxretry,
             retry_max_times: 5,
             retry_timeout: 20.seconds.in_milliseconds,
             arguments: { 'x-dead-letter-exchange': 'downloads-retry' }

  def work(message)
    logger.info JSON.parse(message)
    ack!
  rescue StandardError => e
    logger.error e
    reject!
  end
end
