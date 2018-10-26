class OrdersController < ApplicationController

  def index
    @orders = User.find(current_user.id).orders.all
  end
end
