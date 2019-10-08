class WebhooksController < ApplicationController
  def index
    webhooks = Webhook
      .where(account_id: current_account)
      .includes(:requests)
      .to_a

    render json: webhooks
  end

  def create
    Webhook.create(params[:webhook])

    head :ok
  end
end
