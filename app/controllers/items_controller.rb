class ItemsController < ApplicationController

  def index
    if customer?
      @items = Item.where(status: :active)
    elsif current_merchant? || current_admin?
      @items = Item.all
    end
  end

end
