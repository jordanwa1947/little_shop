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
      @orders = Order.merchant_orders_admin(@merchant_id)
    else
      @merchant_id = current_user.id
      @orders = Order.merchant_orders(@merchant_id)
    end
  end

  def update
    order_item = OrderItem.find(params[:id])
    item = Item.find(params[:item_id])
    order = Order.find(params[:order_id])
    item.update(inventory_count: (item.inventory_count -= order_item.item_quantity))
    order_item.update(order_item_params)
    order.update(status: 'complete') if order.complete? 
    flash[:success] = "Your Item is now Fulfilled"
    redirect_to order_path(params[:order_id], params[:merchant_id], merchant_id: params[:merchant_id])
  end

  private

  def order_item_params
    params.permit(:fulfilled)
  end
end
