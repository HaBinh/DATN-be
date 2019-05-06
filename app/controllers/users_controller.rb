class UsersController < ApplicationController
  
  before_action :only_manager, only: [:index, :update, :destroy]
  before_action :users_params, only: [:update]
  before_action :set_user, only: [:update, :destroy]
  
  def index
    @users = User.where(active: true)
  end

  def update
    @user.update_attributes(users_params)
    render json: { data: @user } 
  end

  def destroy
    @user.toggle_active
    head :ok
  end

  private 

  def set_user
    @user = User.find_by_id(params[:id])
  end

  def users_params
    params.permit(:role, :name)
  end
  
  def only_manager
    unless current_user.isManager 
      render json: { message: 'You are not manager'}, status: :unprocessable_entity
    end
  end
end
