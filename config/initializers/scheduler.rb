require 'rufus-scheduler'
require './app/jobs/evaluator_job'

scheduler = Rufus::Scheduler.new

scheduler.every '30s' do
  EvaluatorJob.execute
end