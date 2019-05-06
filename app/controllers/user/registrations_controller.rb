class User::RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_action :configure_permitted_parameters, only: [:create, :update]
  before_action :authenticate_user!
  before_action :only_manager, only: [:create, :destroy]
  
  # before_action :only_manager_or_correct_user, only: [:update]

  def create
    super
  end

  def update
    
  end

  private 
  
  def only_manager
    unless current_user.isManager 
      render json: { message: 'You are not manager'}, status: :unprocessable_entity
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :role])
  end

end