class Admin::OrdersController < ApplicationController
  # before_action :require_admin

  def index
    @orders = Order.where(user_id: params[:user_id])
  end

end
