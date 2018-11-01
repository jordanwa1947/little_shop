class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents

    flash[:success] = "You now have #{pluralize(@cart.quantity(item.id), item.name)} in your cart"
    redirect_to item_path(item)
  end

  def show
  end

  def destroy
    if session[:cart] != nil
      session[:cart].clear
      flash[:success] = "Your cart has been emptied."
      redirect_to cart_path
    end
  end

  def update
    item = Item.find(params[:item_id])
    if params[:thing] == "increase"
      if @cart.add_item(item.id) == "success"
        flash[:success] = "You now have #{pluralize(@cart.quantity(item.id), item.name)} in your cart"
      end

    elsif params[:thing] == "decrease"
      @cart.subtract_item(item.id)

    elsif params[:thing] == "delete"
      @cart.delete_item(item.id)
    end
    session[:cart] = @cart.contents
    flash[:success] = "You now have #{pluralize(@cart.quantity(item.id), item.name)} in your cart"
    redirect_to cart_path
  end

end
