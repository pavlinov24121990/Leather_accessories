class OrdersController < ApplicationController

  before_action :cart_find, :cart_items_find, only: %i[new create]
  before_action :order_find, only: %i[show]

  include Pagy::Backend

  def create
    @order = current_user.orders.new(order_with_items_params)
    if @order.save
      @cart.cart_items.destroy_all
      redirect_to order_path(@order)
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(:errors_order, partial: "shared/errors", status: :unprocessable_entity, locals: { object: @order }) 
        end
      end
    end
  end

  def show
    @liqpay_request = params_payment
  end

  def index
      @pagy, @orders = pagy(current_user.orders.order(created_at: :desc), items: 4)
  end

  def new
    @order = current_user.orders.build
  end
 
  private

    def params_payment
      @liqpay_request = Liqpay::Request.new({
      amount: @order.price_order_items,
      currency: 'UAH',
      order_id: @order.id,
      description: "Оплата заказа ##{@order.id}",
      result_url: "http://127.0.0.1:3000/liqpay_payment_for_callback",
      server_url: "http://127.0.0.1:3000/liqpay_payment_for_result",
      action: "pay",
      version: "3"
    })
  end

    def cart_items_params
      @cart_items.map do |cart_item|
      { product: cart_item.product, quantity: cart_item.quantity, price: cart_item.product.price.round(2) }
      end
    end

    def order_params
      params.require(:order).permit(:status, :address, :phone_number)
    end

    def order_with_items_params
      order_params.merge(order_items_attributes: cart_items_params)
    end

    def cart_find
      @cart = current_user.cart
    end

    def cart_items_find
      @cart_items = @cart.cart_items
    end

    def order_find
      @order = Order.find(params[:id])
    end

end
