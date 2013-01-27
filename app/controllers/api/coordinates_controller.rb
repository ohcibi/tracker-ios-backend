class Api::CoordinatesController < Api::BaseController
  skip_before_filter :authenticate_with_auth_token, only: [:index, :last]

  def index
    track = Track.find params[:track_id]
    @coordinates = track.coordinates
    respond_with @coordinates do |format|
      format.json { render json: @coordinates.to_json(only: [:id, :lat, :lng]) }
    end
  end

  def last
    track = Track.find params[:track_id]
    @coordinate = track.coordinates.last
    respond_with @coordinate do |format|
      format.json { render json: @coordinate.to_json(only: [:id, :lat, :lng]) }
    end
  end

  def create
    @track = Track.find_by_id params[:track_id]
    return wrong_track_id unless @track
    @coordinates = @track.coordinates.new params[:coordinates]
    if @coordinates.save
      render json: { success: true, message: "success" }
    else
      return invalid_coordinates
    end
  end

  private
    def wrong_track_id
      invalid_access "Wrong track_id", 404
    end
    def invalid_coordinates
      invalid_access "Invalid coordinates", 400
    end
end
