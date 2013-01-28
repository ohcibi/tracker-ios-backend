class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :token_authenticatable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  before_save :ensure_authentication_token
  has_many :tracks

  has_many :friendships
  has_many :buddies, through: :friendships

  default_scope order 'last_seen DESC'

  def tracks_count
    tracks.count
  end

  def md5email
    Digest::MD5.hexdigest email
  end

  def online?
    (last_seen.to_i - (Time.now - 5.minutes).to_i) > 0
  end
end
