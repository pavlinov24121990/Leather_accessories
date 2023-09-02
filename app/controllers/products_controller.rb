class ProductsController < ApplicationController

  include Pagy::Backend

  def index
     @pagy, @products = pagy(Product.order(created_at: :asc), items: 6)
  end
  
end
