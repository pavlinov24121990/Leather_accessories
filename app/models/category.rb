class Category < ApplicationRecord

  has_many :products, inverse_of: :category, dependent: :destroy

  accepts_nested_attributes_for :products

  validates :title, presence: true, length: { minimum: 2, maximum: 20 }
  
end
