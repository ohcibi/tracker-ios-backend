class Api::TracksController < ApplicationController
  respond_to :json
  before_filter :authenticate

  def create
    @track = current_user.tracks.create
    render json: { success: true, track_id: @track.id }
  end

  private
    def authenticate
      user = User.find_for_token_authentication auth_token: params[:auth_token]
      if user
        sign_in user
      else
        render json: { success: false, message: "Not signed in" }, status: 401
      end
    end
end
