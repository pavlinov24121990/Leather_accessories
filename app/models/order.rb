class Order < ApplicationRecord

  belongs_to :user
  belongs_to :cart

  accepts_nested_attributes_for :user

  validates :status, presence: true, inclusion: { in: ['Pending', 'Pending Payment', 'Processing', 'Shipped', 'Completed', 'Canceled'] }
  validates :address, length: { minimum: 2, maximum: 30 }
  validates :phone_number, format: { with: /\A\d{12}\z/, message: "должен быть двенадцатизначным числом без пробелов, дефисов и плюсов" }

end
