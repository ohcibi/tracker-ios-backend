class Coordinates < ActiveRecord::Base
  belongs_to :track
  attr_accessible :lat, :lng
end
