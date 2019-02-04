class Admin < ApplicationRecord
  # can't create a table on the server so
  attr_accessor :subject
  attr_accessor :email
  attr_accessor :password
  validates :password, length: {is: 6}
  validates_presence_of :password
end
