class Api::BaseController < ApplicationController
  respond_to :json
  before_filter :authenticate_with_auth_token
end
