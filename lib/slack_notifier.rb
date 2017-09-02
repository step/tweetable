# frozen_string_literal: true

class SlackNotifier
  USER = 'Tweetable'

  def self.create(web_hook)
    @slack_notifier ||= SlackNotifier.new web_hook
  end

  def notify_for_commence(passage)
    a_ok_note = {
      fallback: 'Everything looks peachy',
      text: 'Hurry up',
      fields: [
        {
          title: 'Title',
          value: passage.title
        },
        {
          title: 'Duration',
          value: PassagesHelper.duration_of_interval_in_words(passage.duration)
        },
        {
          title: 'Conclude Time',
          value: Time.zone.parse(passage.conclude_time.to_s).strftime('%d/%m/%Y %H:%M')
        }
      ],
      color: 'good'
    }
    @notifier.post text: ":loudspeaker: *Hey tweeters* a passage have been commenced at #{Time.zone.parse(passage.commence_time.to_s).strftime('%d/%m/%Y %H:%M')}", attachments: [a_ok_note]
  end

  def notify_for_conclude(passage)
    a_ok_note = {
      fallback: 'Everything looks peachy',
      fields: [
        {
          title: 'Title',
          value: passage.title
        },
        {
          title: 'Duration',
          value: PassagesHelper.duration_of_interval_in_words(passage.duration)
        },
        {
          title: 'Concluded at',
          value: Time.zone.parse(passage.conclude_time.to_s).strftime('%d/%m/%Y %H:%M')
        }
      ],
      color: 'good'
    }
    @notifier.post text: ":loudspeaker: *Hey tweeters* a passage have been concluded at #{Time.zone.parse(passage.conclude_time.to_s).strftime('%d/%m/%Y %H:%M')}", attachments: [a_ok_note]
  end

  private

  def initialize(web_hook, default_channel = '#general')
    @notifier = Slack::Notifier.new web_hook do
      defaults channel: default_channel,
               username: USER
    end
  end
end
