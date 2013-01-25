class Api::TracksController < Api::BaseController
  skip_before_filter :authenticate_with_auth_token, only: :index
  def index
    user = User.find params[:user_id]
    @tracks = user.tracks
    respond_with @tracks do |format|
      format.json { render json: @tracks.to_json(only: [:id, :created_at]) }
    end
  end

  def create
    @track = current_user.tracks.create
    render json: { success: true, track_id: @track.id }
  end

  def destroy
    @track = Track.find params[:id]
    unless @track.user == current_user
      invalid_access "Not your Track!", 401
      return
    end
    @track.destroy
    render json: { success: true }
  end
end
