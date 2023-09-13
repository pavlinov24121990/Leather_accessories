class OrderItem < ApplicationRecord

  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { in: 1..5 }
  validates :price, format: { with: /\A\$?\d+(\.\d{2})?\z/, message: "should be in the format 00.00" },
                   numericality: { greater_than_or_equal_to: 0.01 }
  
end
