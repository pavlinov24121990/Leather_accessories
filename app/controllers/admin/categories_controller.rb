module Admin

  class CategoriesController < AdminController

    def index
      @category = Category.new
      @category.products.build
      @product = Product.new
    end
                              
    def create
      @category = Category.new(category_params)
      if @category.save
        @category = Category.new
        @category.products.build
        flash[:success] = 'Create category and product!'
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [turbo_stream.update(:Create_Category_and_Product, partial: "shared/form_category_product", locals: { category: @category }), 
                                  turbo_stream.update(:flash, partial: "shared/flash")]
           end
        end
      else
        render turbo_stream: turbo_stream.update(:errors, partial: "shared/errors", status: :unprocessable_entity, locals: { object: @category})
      end
    end

    private

    def category_params
      params.require(:category).permit(:title, products_attributes: [:title, :description, :price])
    end

  end

end
