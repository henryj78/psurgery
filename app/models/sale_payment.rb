class SalePayment < ApplicationRecord
  validates :payment_amount, :description,  :presence => true
end
