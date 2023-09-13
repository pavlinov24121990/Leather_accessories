class Product < ApplicationRecord
  
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  has_many :order_items

  has_many_attached :images
  
 
  validates :title, presence: true, length: { minimum: 2, maximum: 20 }
  validates :description, presence: true, length: { minimum: 5, maximum: 100 }
  validates :price, presence:true, numericality: {only_float: true}
  
end
