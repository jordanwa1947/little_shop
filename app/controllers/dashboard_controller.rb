class DashboardController < ApplicationController

  def show
    if current_merchant?
      @merchant = User.find(current_user.id)
    else
      @merchant = User.find(params[:id])
    end
  end

  def index
    if current_admin?
      @orders = Order.distinct.joins(:items).where('items.user_id = ?', params[:merchant_id])
    else
      @orders = Order.distinct.joins(:items).where('items.user_id = ?', current_user.id)
    end
  end
end
