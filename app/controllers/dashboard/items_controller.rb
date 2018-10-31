class Dashboard::ItemsController < ApplicationController
  # before_action :require_merchant

  def index
    @items = Item.where(user_id: current_user.id)
  end

  def new
    @user = current_user
    @item = Item.new
  end

  def create
    @user = current_user
    @item = @user.items.new(item_params)
    if @item.save
      flash[:success] = 'Item Successfully Created!'
      redirect_to dashboard_items_path
    else
      flash[:notice] = "Error in form"
      render :new
    end
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

  private

  def item_params
    params.require(:item).permit(
      :name,
      :price,
      :img_url,
      :inventory_count,
      :description
    )
  end

end
