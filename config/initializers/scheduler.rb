# frozen_string_literal: true

require 'rufus-scheduler'
require './app/jobs/evaluator_job'
require './app/jobs/notifier_job'
require './lib/evaluator/evaluation_engine'
require './lib/evaluator/tagger'
require './lib/slack_notifier'

scheduler = Rufus::Scheduler.new

if Rails.env.production?
  scheduler.every '10s' do
    job = EvaluatorJob.new
    engine = EvaluationEngine.new
    tagger = Tagger.new
    job.execute ResponseQueue, engine, tagger
  end
  scheduler.cron(ENV['SLACK_NOTIFIER_SCHEDULE'] || '00 12 * * *') do
    slack_notifier = SlackNotifier.create ENV['SLACK_WEB_HOOK_URL']
    NotifierJOb.new.execute(slack_notifier)
  end
end
