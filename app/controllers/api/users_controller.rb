class Api::UsersController  < Api::BaseController
  skip_before_filter :authenticate_with_auth_token
  def index
    @users = User.all
    respond_with @users do |format|
      format.json { render json: @users.to_json(only: [:id, :name], methods: :tracks_count) }
    end
  end
end
