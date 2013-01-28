class Api::UsersController  < Api::BaseController
  skip_before_filter :authenticate_with_auth_token
  def index
    @users = User.all
    respond_with @users do |format|
      format.json { render_json_users @users }
    end
  end

  private
  def render_json_users users
    render json: users.to_json(only: [:id, :name, :last_seen], methods: [:md5email, :tracks_count, :online?])
  end
end
