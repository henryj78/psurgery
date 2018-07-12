class Sale < ApplicationRecord
  validates :first_name, :last_name, :territory,  :presence => true
  # TODO Testing Development enviroment - sales
   establish_connection :external_database
end
