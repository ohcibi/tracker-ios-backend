class Track < ActiveRecord::Base
  belongs_to :user
  has_many :coordinates, dependent: :destroy

  def finish!
    self.finished = true
    save
  end
end
