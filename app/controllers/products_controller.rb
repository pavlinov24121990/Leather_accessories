class ProductsController < ApplicationController

  include Pagy::Backend

  before_action :product_find, only: %i[show]

  def index
    if params[:search].present?
      @pagy, @products = pagy(Product.where("title LIKE ?", "%#{params[:search]}%"), items: 6)
    else
      @pagy, @products = pagy(Product.order(created_at: :asc), items: 6)
    end
  end

  def show
    
  end
  
  private

  def product_find
    @product = Product.find(params[:id])
  end

end
