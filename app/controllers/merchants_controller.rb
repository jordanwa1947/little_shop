class MerchantsController < ApplicationController

  def index
    @merchants = User.where(role: 'merchant_user')
  end

  def show
    @merchant = User.find(params[:id])
  end
end
