class OrdersController < ApplicationController

  before_action :cart_items_find, only: %i[create new]
  before_action :cart_find, only: %i[create new]
  before_action :order_find, only: %i[show destroy update]

  include Pagy::Backend

  def create
    @order = @cart.orders.new(order_params)
    @order.user = current_user
    if @order.save
      @cart_items.each do |cart_item|
        order_item = OrderItem.new(
          order: @order,
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: cart_item.product.price
        )
        order_item.save
        @cart.cart_items.destroy_all
      end
      redirect_to order_path(@order)
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(:errors_order, partial: "shared/errors", status: :unprocessable_entity, locals: { object: @order }) 
        end
      end
    end
  end

  def destroy
    if @order.destroy
      redirect_to orders_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    if @order.update(order_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [turbo_stream.update(:order_details, partial: "shared/order_details", status: :unprocessable_entity, locals: { order: @order }), 
                                turbo_stream.update(:errors_order_details, partial: "shared/errors", status: :unprocessable_entity, locals: { object: @order })]
        end
      end
    else
      render turbo_stream: turbo_stream.update(:errors_order_details, partial: "shared/errors", status: :unprocessable_entity, locals: { object: @order })
    end
  end

  def index
    if current_user.admin?
      @pagy, @orders = pagy(Order.all.order(created_at: :desc), items: 4)
    else
      @pagy, @orders = pagy(current_user.orders.order(created_at: :desc), items: 4)
    end
  end

  def new
    @order = current_user.orders.build
  end
 
  private

    def order_params
      params.require(:order).permit(:status, :address, :phone_number)
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
