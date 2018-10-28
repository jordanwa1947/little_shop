class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    flash[:success] = "Item added to Cart"
    redirect_to carts_path
  end

  def show
  end

end
