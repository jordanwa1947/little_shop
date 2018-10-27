class CartsController < ApplicationController

  def create
    cart = session[:cart] || {}
    cart[params[:item_id]] =+ 1
    
    # cart[:item_id] = Item.find(params[:item_id]).name
    session[:cart] = cart

    redirect_to items_path
  end


end
