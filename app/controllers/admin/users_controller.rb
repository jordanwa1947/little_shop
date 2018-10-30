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
    if params[:status] == 'disabled'
      @user.update(disable_or_enable)
      flash[:success] = "#{@user.name}'s account is now disabled"
      redirect_admin
    elsif params[:status] == 'active'
      @user.update(disable_or_enable)
      flash[:success] = "#{@user.name}'s account is now enabled"
      redirect_admin
    elsif params[:role] == 'merchant_user'
      @user.update(upgrade_or_down_grade)
      flash[:success] = "#{@user.name}'s account is now a Merchant"
      redirect_to merchant_path(@user)
    else
      @user.update(upgrade_or_down_grade)
      flash[:success] = "#{@user.name}'s account is now a Registered User"
      redirect_to admin_user_path(@user)
    end
  end

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

  def disable_or_enable
    params.permit(:status)
  end

  def upgrade_or_down_grade
    params.permit(:role)
  end
end
