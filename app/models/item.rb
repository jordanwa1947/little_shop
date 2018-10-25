class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  validates_presence_of :name, :price, :img_url, :inventory_count, :status, :user_id

  enum status: %w(active disabled)
end
