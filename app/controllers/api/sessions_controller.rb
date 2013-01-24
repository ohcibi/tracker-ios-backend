class Api::SessionsController < Devise::SessionsController
  include ApplicationHelper
  prepend_before_filter :require_no_authentication, only: [:create]
  respond_to :json

  def create
    @user = User.find_for_database_authentication email: params[:email]
    return invalid_email unless @user
    return invalid_password unless @user.valid_password? params[:password]
    sign_in "user", @user
    render json: {success: true, auth_token: @user.authentication_token}
  end

  private
    def invalid_email
      invalid_login "Falsche E-Mail Adresse"
    end
    def invalid_password
      invalid_login "Falsches Passwort"
    end
    def invalid_login message
      invalid_access message, 401
    end
end
