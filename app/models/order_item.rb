class OrderItem < ApplicationRecord

  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { in: 1..5 }
  validates :price, presence:true, numericality: {only_float: true}


  def total_price
    price * quantity
  end

  
  
end
