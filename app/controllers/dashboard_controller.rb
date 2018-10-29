class DashboardController < ApplicationController

  def show
    @merchant = User.find(current_user.id)
  end

  def index
    @orders = Order.distinct.joins(:items).where('items.user_id = ?', current_user.id)
  end
end
