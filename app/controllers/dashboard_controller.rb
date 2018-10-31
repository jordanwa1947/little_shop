class DashboardController < ApplicationController

  def show
    if current_admin?
      @merchant = User.find(params[:id])
    else
      @merchant = User.find(current_user.id)
    end

    @three_highest_sellers = User.three_highest_sellers
    @top_selling_states = User.top_states
    @top_cities_1 = User.top_cities
  end

  def index
    if current_admin?
      @merchant_id = params[:merchant_id]
      @orders = Order.distinct.joins(:items).where('items.user_id = ?', params[:merchant_id])
    else
      @merchant_id = current_user.id
      @orders = Order.distinct.joins(:items).where('items.user_id = ?', current_user.id)
    end
  end
end
