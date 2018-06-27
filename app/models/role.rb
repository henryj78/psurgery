class Role < ApplicationRecord
  # TODO Testing Development enviroment - roles
  establish_connection :external_database
end
