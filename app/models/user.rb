class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable #, :registerable, :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
end
