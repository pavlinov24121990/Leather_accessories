class OrdersController < ApplicationController

  before_action :cart_items_find, :cart_find, only: %i[new create]
  before_action :order_find, only: %i[show]

  include Pagy::Backend

  def create
    @order = current_user.orders.new(order_with_items_params)
    @order.user = current_user
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
  end

  def index
      @pagy, @orders = pagy(current_user.orders.order(created_at: :desc), items: 4)
  end

  def new
    @order = current_user.orders.build
  end
 
  private

    def cart_items_params
      @cart_items.map do |cart_item|
      { product: cart_item.product, quantity: cart_item.quantity, price: cart_item.product.price }
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
      @cart_items = current_user.cart.cart_items
    end

    def order_find
      @order = Order.find(params[:id])
    end

end
