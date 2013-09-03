class PingWorker
  require 'net/http'
  TIMEOUT = 5.minutes
  URL = 'http://shortnotes.herokuapp.com/'

  def perform
    send_request
    reschedule
  end

  private

  def send_request
    Net::HTTP.get(URI(URL))
  end

  def reschedule
    Delayed::Job.enqueue(self.class.new, run_at: TIMEOUT.from_now)
  end

end