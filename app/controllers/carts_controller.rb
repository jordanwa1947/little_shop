class CartsController < ApplicationController

  def new
  end

  def create
    cart = session[:cart] || {}
    cart[params[:item_id]] = 1
    session[:cart] = cart
    redirect_to welcome_path
  end

  def show
  end

end
