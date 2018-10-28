class CartsController < ApplicationController


  # def create
  #   @cart = session[:cart] || {}
  #   @cart[params[:item_id]] ||= 0
  #   @cart[params[:item_id]] += 1
  #   session[:cart] = @cart
  #
  #   redirect_to carts_path
  # end

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
