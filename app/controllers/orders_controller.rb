class OrdersController < ApplicationController

  before_action :cart_find, only: %i[create new]
  before_action :order_find, only: %i[show destroy]

  include Pagy::Backend

  def create
    @order = @cart.orders.new(order_params)
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

  def destroy
    if @order.destroy
      redirect_to orders_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  def show
  end

  def index
    @pagy, @orders = pagy(current_user.orders.order(created_at: :asc), items: 4)
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

    def order_find
      @order = Order.find(params[:id])
    end

end
