# frozen_string_literal: true

require 'rufus-scheduler'
require './app/jobs/evaluator_job'
require './lib/evaluator/evaluation_engine'
require './lib/evaluator/tagger'

scheduler = Rufus::Scheduler.new

if Rails.env.production?
  scheduler.every '10s' do
    job = EvaluatorJob.new
    engine = EvaluationEngine.new
    tagger = Tagger.new
    job.execute ResponseQueue, engine, tagger
  end
end
