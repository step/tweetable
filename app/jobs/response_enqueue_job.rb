class ResponseEnqueueJob < Que::Job
  @priority = 10
  @run_at = proc { 1.minute.from_now }
  @queue = :default
  INTERVAL = 3600

  def run
    binding.pry
    response = Response.first()
  end
end