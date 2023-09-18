class LiqpayController < ApplicationController

  protect_from_forgery :except => :payment_callback
  before_action :find_order, only: %i[payment_for_email]

  def payment_for_email
    liqpay = Liqpay.new
    liqpay.api('request', {
      action: 'invoice_send',
      version: '3',
      email: current_user.email,
      amount: @order.price_order_items,
      currency: 'UAH',
      order_id: @order_id,
      goods: map_gods
    })
  end

  def payment_callback
    @liqpay_response = Liqpay::Response.new(params)
    if @liqpay_response.status == "success"
      debugger
      redirect_to products_path
    end
  end

  private
  

  def map_gods
    @order.order_items.map do |order_item|
      {
        amount: order_item.price.round(2),
        count: order_item.quantity,
        unit: "шт.",
        name: order_item.product.title
      }
    end
  end

  def find_order
    @order = Order.find(params[:order_id])
  end

end

def a(a:, b:); end -> a(a: 2, b: 1), a(b: 1, a: 2)
def a(a: 2, b: 1); end -> '-//-'
def a(a, b); end -> a(2, 1) 'a = 2, b = 1'; a(1, 2) 'a = 1, b = 2'
def a(a = 2, b = 1); end -> '-//-'
def a(a, b: 1); end


