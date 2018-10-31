class Dashboard::ItemsController < ApplicationController
  # before_action :require_merchant

  def index
    @items = Item.where(user_id: current_user.id)
  end

end
