module Api

  class BaseController < ActionController::Base
    protect_from_forgery
    before_filter :authenticate
    before_filter :set_current_user
    respond_to :json

    rescue_from CanCan::AccessDenied do |exception|
      render status: 403, json: {message: exception.message}
      return
    end

    private

    def set_current_user
      User.current = current_user
    end

    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        @current_user = User.active.find_by_authentication_token token
      end
    end

  end

end
