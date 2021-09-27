module ErrorHandle
  extend ActiveSupport::Concern

  included do
    class Forbidden < ActionController::ActionControllerError; end
    class Unauthorized < ActionController::ActionControllerError; end

    rescue_from Exception, with: :rescue500
    rescue_from Forbidden, with: :rescue403
    rescue_from Unauthorized, with: :rescue401
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def rescue403(exception)
      if exception
        logger.info "Rendering 403 with exception: #{exception.message}"
      end
      render 'errors/forbidden', status: 403
    end

    def rescue401(exception)
      if exception
        logger.info "Rendering 401 with exception: #{exception.message}"
      end
      render 'errors/unauthorized', status: 401
    end

    def not_found(exception: nil)
      if exception
        logger.info "Rendering 404 with exception: #{exception.message}"
      end
      render 'errors/404', status: 404
    end

    def rescue500(exception)
      if exception
        logger.info "Rendering 500 with exception: #{exception.message}"
      end
      render 'errors/500', status: 500
    end
  end
end
