class Dashboard::ItemsController < ApplicationController
  # before_action :require_merchant

  def index
    @items = Item.where(user_id: current_user.id)
  end

  def new

  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
      if params[:status] == 'disable'
        item.update(status: 1)
        flash[:success] = "#{item.name} is no longer for sale"
        redirect_to dashboard_items_path
      elsif params[:status] == 'enable'
        item.update(status: 0)
        flash[:success] = "#{item.name} is now available for sale"
        redirect_to dashboard_items_path
      else
        render file: "/public/404"
      end
  end

  def show
  end

end
