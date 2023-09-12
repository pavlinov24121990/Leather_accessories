class CartItemsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_product, only: %i[create] 
  before_action :set_cart_item, only: %i[destroy update] 
  
  def create
    unless current_user.cart
      current_user.create_cart
    end
    cart_item = current_user.cart.cart_items.find_by(product_id: cart_item_params[:product_id])
    if cart_item.present?
      new_quantity = cart_item_params[:quantity].to_i
      if new_quantity > cart_item.quantity
        cart_item.update(quantity: new_quantity)
      end
      cart_item.update(quantity: cart_item.quantity + cart_item_params[:quantity].to_i)
      redirect_to cart_path(current_user.cart)
    else
      current_user.cart.cart_items.create(cart_item_params)
      redirect_to cart_path(current_user.cart)
    end
  end

  def update
    if @cart_item.update(cart_item_params)
      @cart = current_user.cart 
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(:cart_items, partial: "shared/cart_item", locals: { cart: @cart }) 
        end
      end
    else
        render turbo_stream: turbo_stream.update(:errors_cart_items, partial: "shared/errors", status: :unprocessable_entity, locals: { object: @cart_item })
    end
  end

  def destroy
    if @cart_item.destroy
      @cart = current_user.cart 
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(:cart_items, partial: "shared/cart_item", locals: { cart: @cart }) 
        end
      end
    end
  end

  private 

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end
end
