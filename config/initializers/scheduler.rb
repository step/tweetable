require 'rufus-scheduler'
require './app/jobs/evaluator_job'

def shedule
  scheduler = Rufus::Scheduler.new

  scheduler.every '30s' do
    EvaluatorJob.execute
  end
end

shedule if Rails.env.production?