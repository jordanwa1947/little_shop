class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    flash[:success] = "Item added to Cart: you now have #{pluralize(@cart.quantity(item.id), item.name)}"
    redirect_to carts_path
  end

  def show
  end

  def destroy
    session[:cart].clear
    flash[:success] = "Your cart has been emptied."
    redirect_to carts_path
  end

end
