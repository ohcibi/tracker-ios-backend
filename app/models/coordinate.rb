class Coordinate < ActiveRecord::Base
  belongs_to :track
  attr_accessible :lat, :lng

  validates :lat, numericality: true
  validates :lng, numericality: true
end
