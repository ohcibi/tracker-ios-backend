class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :token_authenticatable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :tracks_count, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  before_save :reset_authentication_token
  has_many :tracks
end
