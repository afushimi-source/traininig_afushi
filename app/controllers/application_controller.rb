class ApplicationController < ActionController::Base
  include ErrorHandle
  include SessionsHelper

  http_basic_authenticate_with name: ENV['BASIC_AUTH_NAME'], password: ENV['BASIC_AUTH_PASSWORD'] if Rails.env.production?

  private

  def logged_in_user
    return if logged_in?

    flash[:danger] = t 'users.flash.not_login'
    redirect_to login_url
  end
end
