class ProductsController < ApplicationController

  include Pagy::Backend

  before_action :product_find, only: %i[show]

  def index
     @pagy, @products = pagy(Product.order(created_at: :asc), items: 6)
  end

  def show
    
  end
  
  private

  def product_find
    @product = Product.find(params[:id])
  end

end
