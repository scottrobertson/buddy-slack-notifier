# frozen_string_literal: true

require 'slack-ruby-client'

class Notify
  def initialize(token)
    Slack.configure do |config|
      config.token = token
    end

    @client = Slack::Web::Client.new
  end

  def notify(status, chat_id: nil)
    blocks = [
      {
        type: "section",
        fields: [
          {
            type: "mrkdwn",
            text: "*App*"
          },
          {
            type: "mrkdwn",
            text: "*Environment*"
          },
          {
            type: "mrkdwn",
            text: ENV['APP_NAME']
          },
          {
            type: "mrkdwn",
            text: ENV['ENVIRONMENT']
          }
        ]
      },
      {
        type: "section",
        fields: [
          {
            type: "mrkdwn",
            text: "*Status*"
          },
          {
            type: "mrkdwn",
            text: "*Commit Hash*"
          },
          {
            type: "mrkdwn",
            text: status
          },
          {
            type: "mrkdwn",
            text: "<#{ENV['BUDDY_EXECUTION_REVISION_URL']}|#{ENV['BUDDY_EXECUTION_REVISION_SHORT']}>"
          },
        ]
      },
      {
        type: "section",
        fields: [
          {
            type: "mrkdwn",
            text: "*Commiter*"
          },
          {
            type: "mrkdwn",
            text: "*Commit Message*"
          },
          {
            type: "mrkdwn",
            text: ENV['BUDDY_EXECUTION_REVISION_COMMITTER_NAME']
          },
          {
            type: "mrkdwn",
            text: ENV['BUDDY_EXECUTION_REVISION_MESSAGE']
          },
        ]
      },
      {
        type: "context",
        elements: [
          {
            type: "mrkdwn",
            text: "*Build:* <#{ENV['BUDDY_EXECUTION_URL']}|#{ENV['BUDDY_EXECUTION_ID']}>"
          },
          {
            type: "mrkdwn",
            text: "*Time Taken:* #{ENV['BUDDY_EXECUTION_TIME']}"
          }
        ]
      }
    ]

    begin
      if chat_id.to_s.empty?
        @client.chat_postMessage(
          channel: ENV['CHANNEL'],
          blocks: blocks,
        )
      else
        @client.chat_update(
          channel: ENV['CHANNEL'],
          ts: chat_id,
          blocks: blocks,
        )
      end
    rescue => e
      puts e.response.body
      raise
    end
  end
end
