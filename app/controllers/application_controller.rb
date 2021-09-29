class ApplicationController < ActionController::Base
  include SessionsHelper

  http_basic_authenticate_with name: ENV['BASIC_AUTH_NAME'], password: ENV['BASIC_AUTH_PASSWORD'] if Rails.env.production?

  class Forbidden < ActionController::ActionControllerError; end

  class Unauthorized < ActionController::ActionControllerError; end

  rescue_from Forbidden, with: :rescue403
  rescue_from Unauthorized, with: :rescue401

  private

  def logged_in_user
    return if logged_in?

    flash[:danger] = t 'users.flash.not_login'
    redirect_to login_url
  end

  def rescue403(exception)
    logger.error "Rendering 403 with exception: #{exception.message}" if exception
    render 'errors/forbidden', status: :forbidden
  end

  def rescue401(exception)
    logger.error "Rendering 401 with exception: #{exception.message}" if exception
    render 'errors/unauthorized', status: :unauthorized
  end
end
