desc 'Start ping process'
task start_worker: :environment do
  Delayed::Job.enqueue(PingWorker.new, run_at: 5.seconds.from_now)
end
