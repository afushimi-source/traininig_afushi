module ErrorHandle
  extend ActiveSupport::Concern
  class Forbidden < ActionController::ActionControllerError; end

  class Unauthorized < ActionController::ActionControllerError; end

  included do
    rescue_from Exception, with: :rescue500
    rescue_from Forbidden, with: :rescue403
    rescue_from Unauthorized, with: :rescue401
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def rescue500(exception = nil)
      logger.error "Rendering 500 with exception: #{exception.message}" if exception
      render 'errors/500', status: :internal_server_error
    end

    def rescue403(exception = nil)
      logger.error "Rendering 403 with exception: #{exception.message}" if exception
      render 'errors/forbidden', status: :forbidden
    end

    def rescue401(exception = nil)
      logger.error "Rendering 401 with exception: #{exception.message}" if exception
      render 'errors/unauthorized', status: :unauthorized
    end

    def not_found(exception = nil)
      logger.error "Rendering 404 with exception: #{exception.message}" if exception
      render 'errors/404', status: :not_found
    end
  end
end
