class Customer < ApplicationRecord
 has_many :zones

  # TODO Testing Development enviroment - customer
  establish_connection :external_database
end
