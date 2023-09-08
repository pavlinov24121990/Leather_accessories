class Users::RegistrationsController < Devise::RegistrationsController

  prepend_before_action :require_no_authentication, only: [:new, :create, :cancel]
  prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy]
  prepend_before_action :set_minimum_password_length, only: [:new, :edit]

  def new
    super
  end

  def create
    super
    unless current_user.cart
      current_user.create_cart
    end
  end

  def edit
    super
  end

  def update
    super
  end

  def destroy
    super
  end

  
  def cancel
    super
  end

  protected

  def update_needs_confirmation?(resource, previous)
   super
  end

  def update_resource(resource, params)
    super
  end

  def build_resource(hash = {})
    super
  end

  def sign_up(resource_name, resource)
    super
  end

  def after_sign_up_path_for(resource)
    super
  end

  def after_inactive_sign_up_path_for(resource)
   super
  end

  def after_update_path_for(resource)
    super
  end

  def authenticate_scope!
    super
  end

  def sign_up_params
    super
  end

  def account_update_params
    super
  end

  def translation_scope
    super
  end

  private

  def set_flash_message_for_update(resource, prev_unconfirmed_email)
    super
  end

  def sign_in_after_change_password?
    super
  end
end