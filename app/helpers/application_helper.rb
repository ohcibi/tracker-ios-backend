module ApplicationHelper
  def invalid_access message, code
    render json: { success: false, message: message }, status: code
  end

  def authenticate_with_auth_token
    user = User.find_for_token_authentication auth_token: params[:auth_token]
    if user
      sign_in user
      session[:auth_token] = user.authentication_token
    else
      render json: { success: false, message: "Not signed in" }, status: 401
    end
  end

  def update_last_seen
    user = User.find_by_authentication_token params[:auth_token]
    if user
      user.last_seen = DateTime.now
      user.save
    end
  end
end
