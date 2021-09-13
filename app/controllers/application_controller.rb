class ApplicationController < ActionController::Base
  include SessionsHelper

  http_basic_authenticate_with name: ENV['BASIC_AUTH_NAME'], password: ENV['BASIC_AUTH_PASSWORD'] if Rails.env.production?

  private

  def logged_in_user
    unless logged_in?
      flash[:error] = t 'users.flash.not_login'
      redirect_to login_url
    end
  end
end
