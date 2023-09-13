class ProductsController < ApplicationController

  include Pagy::Backend

  before_action :product_find, only: %i[show]
  

  def index
    @pagy, @products = pagy(products, items: 6)
  end

  def show
    
  end
  
  private

  def product_find
    @product = Product.find(params[:id])
  end

  def products
    products = if params[:search].present?
    Product.where("title LIKE ?", "%#{params[:search]}%")
  else
    Product.all
  end
    products.order(created_at: :asc)
  end

end
