class Customer < ApplicationRecord
  # TODO Testing Development enviroment
  establish_connection :external_database
end
