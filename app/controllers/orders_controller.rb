class OrdersController < ApplicationController

  def index
    @orders = User.find(current_user.id).orders.all
  end

  def show
  end

  def create
    order = Order.create(user_id: session[:user_id], status: :pending)

    session[:cart].each do |key, value|
      item = Item.find(key.to_i)
      OrderItem.create(order_id: order.id, item_id: key.to_i, item_quantity: value, item_price: item.price)
    end

    session[:cart].clear
    redirect_to profile_orders_path(current_user)
  end
end
