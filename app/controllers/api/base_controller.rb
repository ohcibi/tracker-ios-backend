class Api::BaseController < ApplicationController
  respond_to :json
  before_filter :authenticate_with_auth_token

  protected
    def invalid_access message, code
      render json: { success: false, message: message }, status: code
    end

    def authenticate_with_auth_token
      user = User.find_for_token_authentication auth_token: params[:auth_token]
      if user
        sign_in user
      else
        render json: { success: false, message: "Not signed in" }, status: 401
      end
    end
end
