class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.status == 'active'
      @user.update(disable)
      flash[:success] = "#{@user.name}'s account is now disabled"
      redirect_admin
    else
      @user.update(enable)
      flash[:success] = "#{@user.name}'s account is now enabled"
      redirect_admin
    end
  end
#maybe this shouldn't be here? Need feedback
  def redirect_admin
    if @user.role == 'merchant_user'
      redirect_to merchants_path
    else
      redirect_to admin_users_path
    end
  end

  private

  def require_admin
    render file: "/public/404" unless current_admin?
  end

  def disable
    params.permit(:status)
  end

  def enable
    params.permit(:status)
  end
end
