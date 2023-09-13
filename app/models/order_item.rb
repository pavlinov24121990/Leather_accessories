class OrderItem < ApplicationRecord

  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { in: 1..5 }
  
end
