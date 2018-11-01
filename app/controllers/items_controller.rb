class ItemsController < ApplicationController

  def index
    if customer?
      @items = Item.where(status: :active)
    elsif current_merchant? || current_admin?
      @items = Item.all
    end
    @cart = Cart.new(session[:cart])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      flash[:success] = 'Item Successfully Updated!'
      redirect_to dashboard_items_path
    else
      flash[:notice] = 'Error in form'
      render :edit
    end
  end

  def show
    @item = Item.find(params[:id])
    @seller = User.find(Item.find(params[:id]).user_id)
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
 