class MerchantsController < ApplicationController
  before_action :require_admin, only: [:show]

  def index
    @merchants = User.where(role: 'merchant_user')
  end

  def show
    @merchant = User.find(params[:id])
  end

  private

  def require_admin
    render file: "/public/404" unless current_admin?
  end
end
