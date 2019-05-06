require 'will_paginate/array'
class ApplicationController < ActionController::API
  respond_to :json
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!, unless: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :email])
  end

  def myCeil(value)
    (value / 100.0).ceil * 100
  end

end
