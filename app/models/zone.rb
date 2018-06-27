class Zone < ApplicationRecord
  belongs_to :customer

  # TODO Testing Development enviroment - zones
  establish_connection :external_database
end
