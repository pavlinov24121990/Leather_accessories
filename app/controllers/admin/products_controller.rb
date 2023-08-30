module Admin

  class ProductsController < AdminController

    def index
    end
                              
    def create
      @product = Product.new(product_params)
      if @product.save
        flash[:success] = 'Create product in category!'
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [turbo_stream.update(:Create_Product_in_Category, partial: "shared/form_product", locals: { product: @product }), 
                                  turbo_stream.update(:flash, partial: "shared/flash")]
           end
        end
      else
        render turbo_stream: turbo_stream.update(:errors_product, partial: "shared/errors", status: :unprocessable_entity, locals: { object: @product })
      end
    end

    private

    def product_params
      params.require(:product).permit(:title, :description, :price, :category_id, images: [])
    end

  end

end
