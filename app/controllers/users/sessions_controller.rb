class Users::SessionsController < Devise::SessionsController

  before_action :configure_sign_in_params, only: [:create]

  def new
    super
  end
  
  def create
    self.resource = warden.authenticate(auth_options)
    if resource
      sign_in(resource_name, resource)
      yield resource if block_given?
      redirect_to after_sign_in_path_for(resource)
      unless current_user.cart
        current_user.create_cart
      end
    else
      flash[:success] = 'Invalid email or password.'
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(:flash_session, partial: "shared/flash")
        end
      end
    end
  end

  def destroy
      current_user.cart.destroy
    super
  end

  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_products_path
    else
      products_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    products_path
  end
  
  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
