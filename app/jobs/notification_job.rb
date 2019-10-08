class NotificationJob < ApplicationJob
  queue_as :default

  # retry errors with HTTP requests
  retry_on HTTP::Error

  def perform(webhook)
    webhook.notify
  end
end
