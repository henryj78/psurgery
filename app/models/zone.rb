class Zone < ApplicationRecord
  belongs_to :customer
  has_many :states

  # TODO Testing Development enviroment - zones
   establish_connection :external_database
end
