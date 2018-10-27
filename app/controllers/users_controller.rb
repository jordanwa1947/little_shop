class UsersController < ApplicationController

  def new
    if session[:user]
      # binding.pry
      session[:user][:email] = nil
      # binding.pry
      @user = User.new(session[:user])
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'You are now registered and logged in'
      redirect_to profile_path
    else
      session[:user] = @user
      flash[:error] = 'Email Address already exists'
      redirect_to new_user_path
    end
  end

  def edit
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:success] = 'Your Info Was Successfully Updated!'
      redirect_to profile_path
    else
      flash[:notice] = "Email address already in use"
      redirect_to profile_edit_path
    end
  end

  def show

  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :address,
      :city,
      :state,
      :zip_code,
      :password,
      :email
    )
  end
end
