class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :rememberable, :trackable, :validatable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :validatable
  has_many :searches
end
