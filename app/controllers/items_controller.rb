class ItemsController < ApplicationController

  def index
    if customer?
      @items = Item.where(status: :active)
    elsif current_merchant? || current_admin?
      @items = Item.all
    end
    @cart = Cart.new(session[:cart])

    @three_highest_selling_items = Item.three_highest_selling_items
  end

  def show
    @item = Item.find(params[:id])
    @seller = User.find(Item.find(params[:id]).user_id)
  end

end
