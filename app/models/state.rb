class State < ApplicationRecord
  belongs_to :zone
  has_many :counties

  # TODO Testing Development enviroment - state
  # establish_connection :external_database

  def ordered_counties
   counties.order(:name)
  end
end
