class Order < ApplicationRecord

  belongs_to :user
  belongs_to :cart
  has_many :order_items, dependent: :destroy

  validates :status, presence: true
  validates :address, length: { minimum: 2, maximum: 30 }
  validates :phone_number, format: { with: /\A\d{12}\z/, message: "должен быть двенадцатизначным числом без пробелов, дефисов и плюсов" }

  enum status: {
    pending: "Pending",
    pending_payment: "Pending Payment",
    processing: "Processing",
    shipped: "Shipped",
    completed: "Completed",
    canceled: "Canceled"
  }

  after_initialize :set_default_status, if: :new_record?

  def price_order_items
    order_items.sum { |order_item| order_item.total_price }
  end

  private

  def set_default_status
    self.status ||= 'Pending'
  end
  

end
