class CartsController < ApplicationController

  def new
  end

  def create
    cart = session[:cart] || {}
    cart[params[:item_id]] = 1
    redirect_to root_path
  end

  def show
  end

end
