class Webhook < ApplicationRecord
  belongs_to :account
  has_many :requests, class_name: "WebhookRequest"

  after_create_commit :notify_later

  def notify_later
    NotificationJob.perform_later(webhook)
  end

  def notify
    response = HTTP.post(url, body: payload, headers: headers)

    WebhookRequest.create(
      status:  response.status.to_i,
      headers: response.headers.to_h,
      body:    response.body.to_s,
    )
  rescue HTTP::Error => exception
    WebhookRequest.create(
      status:    0, # indicates exception
      exception: {
        class:     exception.class,
        message:   exception.message,
        backtrace: exception.backtrace,
      }
    )

    raise # re-raise the exception
  end
end
