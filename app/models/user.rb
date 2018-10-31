class User < ApplicationRecord
  validates_presence_of :name, require: true
  validates_presence_of :address, require: true
  validates_presence_of :city, require: true
  validates_presence_of :state, require: true
  validates_presence_of :zip_code, require: true
  validates_presence_of :password_digest, require: true
  validates :email, presence: true, uniqueness: true
  validates_confirmation_of :password

  has_many :items
  has_many :orders
  has_many :order_items, through: :orders

  has_secure_password

  enum role: %w(registered_user merchant_user admin_user)
  enum status: %w(active disabled)


  def self.three_highest_sellers
    sellers = group(:id).joins(:order_items).sum(:item_quantity)
    desc = sellers.sort {|a,b| b[1]<=>a[1]}
    top_three = desc[0..2].map do |seller|
      User.find(seller.first.to_i)
    end
  end

  def self.fastest_shippers

  end

  def self.slowest_shippers

  end

end
