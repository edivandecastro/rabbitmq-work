class ProfilingWorker
  include Sneakers::Worker

  from_queue 'downloads',
             exchange: 'download_process',
             timeout_job_after: 1

  def work(message)
    begin
      logger.info JSON.parse(message)
    rescue StandardError => e
      logger.error e
    end

    ack!
  end
end
