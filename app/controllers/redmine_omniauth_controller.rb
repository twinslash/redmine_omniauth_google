require 'account_controller'

class RedmineOmniauthController < ApplicationController
  def omniauth_google
    AccountController.new.send(:open_id_authenticate, params[:openid_url])
  end
end
