class MerchantsController < ApplicationController

  def index
    @merchants = User.where(role: 'merchant_user')
  end
end
