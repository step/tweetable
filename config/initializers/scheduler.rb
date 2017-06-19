# frozen_string_literal: true

require 'rufus-scheduler'
require './app/jobs/evaluator_job'

scheduler = Rufus::Scheduler.new

scheduler.every '10s' do
  job = EvaluatorJob.new
  engine = EvaluationEngine.new
  tagger = Tagger.new
  job.execute ResponseQueue, engine, tagger
end

shedule if Rails.env.production?
