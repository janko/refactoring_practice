class ApplicationController < ActionController::Base
  before_action :count_visits

  def count_visits
    VisitCounter.call(current_account) if current_account?
  rescue Redis::BaseConnectionError => exception
    Raven.capture_exception(exception) # report the exception
    # don't let a Redis connection failure take down the request
  end

  def current_account=(account)
    session[:current_account] = account.id
  end

  def current_account
    Account.find(session[:current_account]) if current_account?
  end

  def current_account?
    !!session[:current_account]
  end
end
