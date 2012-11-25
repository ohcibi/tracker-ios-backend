class Api::CoordinatesController < Api::BaseController
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
