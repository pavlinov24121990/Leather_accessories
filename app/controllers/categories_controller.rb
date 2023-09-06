class CategoriesController < ApplicationController

  include Pagy::Backend
  
  before_action :category_find

  def show
    @pagy, @products = pagy(@category.products.order(created_at: :asc), items: 6)
  end

  private

  def category_find
    @category = Category.find(params[:id])
  end
end
