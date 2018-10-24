class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # :registerable,  - removed from line below. (sign up)
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :timeoutable, :timeout_in => 60.minutes
end
