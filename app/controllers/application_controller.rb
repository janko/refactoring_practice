class ApplicationController < ActionController::Base
  def current_account=(account)
    session["current_account"] = account.id
  end

  def current_account
    Account.find(session["current_account"]) if session["current_account"]
  end
end
