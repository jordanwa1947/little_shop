class CartsController < ApplicationController


  def create
    @cart = session[:cart] || {}
    @cart[params[:item_id]] ||= 0
    @cart[params[:item_id]] += 1
    session[:cart] = @cart

    redirect_to items_path
  end

  # def create
  #   item = Item.find(params[:item_id])
  #   @cart.add_item(item)
  #   session[:cart] = @cart.contents
  #   redirect_to items_path
  # end

  def show
    @cart = session[:cart]
    if @cart
      @items = @cart.keys.map do |item_id|
        Item.find(item_id.to_i)
      end
    end
  end

end
