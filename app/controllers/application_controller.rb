class ApplicationController < ActionController::Base
  include SessionsHelper

  http_basic_authenticate_with name: ENV['BASIC_AUTH_NAME'], password: ENV['BASIC_AUTH_PASSWORD'] if Rails.env.production?

  class Forbidden < ActionController::ActionControllerError; end

  rescue_from Forbidden, with: :rescue403

  class Unauthorized < ActionController::ActionControllerError; end

  rescue_from Unauthorized, with: :rescue401

  private

  def logged_in_user
    return if logged_in?

    flash[:danger] = t 'users.flash.not_login'
    redirect_to login_url
  end

  def rescue403(e)
    @exception = e
    render 'errors/forbidden', status: 403
  end

  def rescue401(e)
    @exception = e
    render 'errors/unauthorized', status: 401
  end
end
