class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: true, numericality: { in: 1..5 }

  def total_price
    product.price * quantity
  end

end
