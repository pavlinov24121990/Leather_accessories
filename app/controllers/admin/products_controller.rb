module Admin

  class ProductsController < AdminController

    include Pagy::Backend

    before_action :product_find, only: %i[show update destroy]

    def index
      @pagy, @products = pagy(Product.order(created_at: :asc), items: 6)
    end

    def show
      @buttonupdate = true
    end

    def destroy
      if @product.destroy
        redirect_to admin_products_path
      else
        render :show, status: :unprocessable_entity
      end
    end

    def update
      if @product.update(product_params)
        flash[:success] = 'Update product in category!'
        @buttonupdate = true
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [turbo_stream.update(:Update_Product_in_Category_form, partial: "shared/form_product", locals: { product: @product, buttonupdate: @buttonupdate }), 
                                  turbo_stream.update(:Update_Product_in_Category, partial: "shared/product", locals: { product: @product, buttonupdate: @buttonupdate }),
                                  turbo_stream.update(:flash, partial: "shared/flash")]
           end
        end
      else
        render turbo_stream: turbo_stream.update(:errors_product, partial: "shared/errors", status: :unprocessable_entity, locals: { object: @product })
      end
    end
                              
    def create
      @product = Product.new(product_params)
      if @product.save
        @product = Product.new
        flash[:success] = 'Create product in category!'
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [turbo_stream.update(:Create_Product_in_Category, partial: "shared/form_product", locals: { product: @product, buttonupdate: @buttonupdate }), 
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

    def product_find
      @product = Product.find(params[:id])
    end

  end

end
