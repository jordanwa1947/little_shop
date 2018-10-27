class CartsController < ApplicationController


  def create
    cart = session[:cart] || {}
    cart[params[:item_id]] ||= 0
    cart[params[:item_id]] += 1
    session[:cart] = cart
    redirect_to items_path
  end


end
