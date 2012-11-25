class Api::TracksController < Api::BaseController
  def create
    @track = current_user.tracks.create
    render json: { success: true, track_id: @track.id }
  end
end
