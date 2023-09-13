class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  def total_price
    cart_items.sum { |cart_item| cart_item.total_price }
  end
  
end
