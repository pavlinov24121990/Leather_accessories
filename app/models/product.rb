class Product < ApplicationRecord
  
  belongs_to :category
  has_many :cart_items

  has_many_attached :images
  
 
  validates :title, presence: true, length: { minimum: 2, maximum: 20 }
  validates :description, presence: true, length: { minimum: 5, maximum: 100 }
  validates :price, format: { with: /\A\$?\d+(\.\d{2})?\z/, message: "should be in the format 00.00" },
                   numericality: { greater_than_or_equal_to: 0.01 }
end
