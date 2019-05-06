class User::SessionsController < DeviseTokenAuth::SessionsController

  before_action :check_active_user, only: :create

  def create
    super
  end

  private

  def check_active_user
    @user = User.find_by(email: params[:email]) 
    unless @user.nil? 
      unless @user.isActive
        render_user_not_active and return
      end
    end
  end

  def render_user_not_active
    render json: { errors: ['This account has been disabled']}, status: :unprocessable_entity
  end
end