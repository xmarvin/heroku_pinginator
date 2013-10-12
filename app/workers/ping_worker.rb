class PingWorker
  require 'net/http'
  TIMEOUT = 5.minutes
  URLS = ['http://skills.pp.ua/']

  def perform
    send_request
    reschedule
  end

  private

  def send_request
    URLS.each do |url|
      Net::HTTP.get(URI(url)) rescue nil
    end
  end

  def reschedule
    Delayed::Job.enqueue(self.class.new, run_at: TIMEOUT.from_now)
  end

end