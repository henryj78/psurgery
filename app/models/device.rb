class Device < ApplicationRecord
  belongs_to :customer

  # TODO Testing Development enviroment - customer
  establish_connection :external_database
end
