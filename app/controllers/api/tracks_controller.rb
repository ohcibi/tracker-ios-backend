class Api::TracksController < ApplicationController
  respond_to :json
  before_filter :authenticate

  def create
    render json: { success: true }
  end

  private
    def authenticate
      return if user_signed_in?
      render json: { success: false, message: "Not signed in" }, status: 401
    end
end
