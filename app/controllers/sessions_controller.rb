class SessionsController < ApplicationController
  def create
    self.current_account = Account.find_or_create_from_omniauth(auth_hash)

    redirect_to "/"
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end
end
