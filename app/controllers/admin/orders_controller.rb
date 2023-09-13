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
    
    def order_params
      params.require(:order).permit(:status, :address, :phone_number)
    end

    def order_find
      @order = Order.find(params[:id])
    end


  end 
end
