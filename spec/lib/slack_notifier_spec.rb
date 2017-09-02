# frozen_string_literal: true

require './lib/slack_notifier'
describe SlackNotifier do
  let(:slack_notifier) { SlackNotifier.create('https://webhook.com') }
  describe 'create' do
    it 'slack notifier' do
      expect(slack_notifier).to be_a_kind_of(SlackNotifier)
    end
  end

  describe 'notify_for_commence' do
    it 'call Slack::Notifier.post with correct args' do
      passage = double(:passage, title: 'Title', commence_time: Time.zone.now + 1.day, conclude_time: Time.zone.now + 2.day, duration: 86_400)
      attachment = {
        fallback: 'Everything looks peachy',
        text: 'Hurry up',
        fields: [
          {
            title: 'Title',
            value: passage.title
          },
          {
            title: 'Duration',
            value: '1 day'
          },
          {
            title: 'Conclude Time',
            value: Time.zone.parse(passage.conclude_time.to_s).strftime('%d/%m/%Y %H:%M')
          }
        ],
        color: 'good'
      }

      expect_any_instance_of(Slack::Notifier).to receive(:post).with(text: ":loudspeaker: *Hey tweeters* a passage have been commenced at #{Time.zone.parse(passage.commence_time.to_s).strftime('%d/%m/%Y %H:%M')}", attachments: [attachment])
      slack_notifier.notify_for_commence passage
    end
  end

  describe 'notify_for_conclude' do
    it 'call Slack::Notifier.post with correct args' do
      passage = double(:passage, title: 'Title', commence_time: Time.zone.now + 1.day, conclude_time: Time.zone.now + 2.day, duration: 86_400)
      attachment = {
        fallback: 'Everything looks peachy',
        fields: [
          {
            title: 'Title',
            value: passage.title
          },
          {
            title: 'Duration',
            value: '1 day'
          },
          {
            title: 'Concluded at',
            value: Time.zone.parse(passage.conclude_time.to_s).strftime('%d/%m/%Y %H:%M')
          }
        ],
        color: 'good'
      }

      expect_any_instance_of(Slack::Notifier).to receive(:post).with(text: ":loudspeaker: *Hey tweeters* a passage have been concluded at #{Time.zone.parse(passage.conclude_time.to_s).strftime('%d/%m/%Y %H:%M')}", attachments: [attachment])
      slack_notifier.notify_for_conclude passage
    end
  end
end
