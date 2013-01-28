class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  before_filter :update_last_seen
end
