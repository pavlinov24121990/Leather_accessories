module Admin

  class OrdersController < AdminController

    include Pagy::Backend

    before_action :order_find, only: %i[show destroy update]

    def index
      @pagy, @orders = pagy(Order.all.order(created_at: :desc), items: 4)
    end

    def destroy
      if @order.destroy
        redirect_to orders_path
      else
        render :show, status: :unprocessable_entity
      end
    end

    def show
      @liqpay_request = params_payment
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

    private

    def params_payment
      @liqpay_request = Liqpay::Request.new(
  amount: '999.99',
  currency: 'UAH',
  order_id: '123',
  description: 'Some Product',
  result_url: products_path,
  server_url: liqpay_payment_for_result_path
)
      # liqpay = Liqpay.new
      # liqpay.cnb_form({
      #   action:      "pay",
      #   amount:      @order.price_order_items,
      #   currency:    "UAH",
      #   description: "Оплата заказа ##{@order.id}",
      #   order_id:    @order.id,
      #   version:     "3",
      #   result_url: "http://127.0.0.1:3000/"
      # })
    end
    
    def order_params
      params.require(:order).permit(:status, :address, :phone_number)
    end

    def order_find
      @order = Order.find(params[:id])
    end


  end 
end
