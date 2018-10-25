class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'You are now registered and logged in'
      redirect_to profile_path
    else
      flash[:error] = 'Email Address already exists'
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    update_info = User.update(update_params)
    flash.notice = 'Your Info Was Successfully Updated!'
    redirect_to profile_path
  end

  def show

  end

  private

  def user_params
    params.require(:user).permit(:name, :address, :city, :state,
                                 :zip_code, :password, :email)
  end

  def update_params
    params.require(:user).permit(:name, :address, :city, :state,
                                  :zip_code, :email)
  end
end
