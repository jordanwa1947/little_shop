class OrdersController < ApplicationController

  def index
    @orders = User.find(current_user.id).orders.all
  end

  def show
  end

  def create
    if session[:cart] == nil || session[:cart] == {}
      flash[:sucess] = "You have no items in your cart"

    elsif session[:cart] != nil
      order = Order.create(user_id: session[:user_id], status: :pending)

      session[:cart].each do |key, value|
        item = Item.find(key.to_i)
        order.order_items.create(item_id: key.to_i, item_quantity: value, item_price: item.price)
      end

      session[:cart].clear
      redirect_to profile_orders_path(current_user)
    end
  end
end
