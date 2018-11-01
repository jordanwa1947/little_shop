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
    select('users.*, sum(order_items.item_price * order_items.item_quantity) as total_sales')
      .joins(items: :order_items)
      .group('users.id')
      .order('total_sales DESC')
      .limit(3)
  end

  def self.top_states
    select('users.state, sum(order_items.item_price * order_items.item_quantity) as total_sales')
    .joins(items: :order_items)
    .group(:state)
    .order('total_sales DESC')
    .limit(3)
  end

  def self.top_cities
    # select users.city, sum(order_items.item_price * order_items.item_quantity)
    # from users
    # join items on items.user_id= users.id
    # join order_items on order_items.item_id = items.id
    # group by users.city;
   end


end
