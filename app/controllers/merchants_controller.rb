class MerchantsController < ApplicationController
  before_action :require_merchant_or_admin, only: [:show]

  def index
    @merchants = User.where(role: 'merchant_user')
  end

  def show
    if current_merchant?
      @merchant = User.find(current_user.id)
    else
      @merchant = User.find(params[:id])
    end
  end

  private

  def require_merchant_or_admin
    render file: "/public/404" unless current_merchant? or current_admin?
  end
end
