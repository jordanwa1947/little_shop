class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  validates_presence_of :name, :price, :img_url, :inventory_count, :status, :user_id, :description

  enum status: %w(active disabled)

  def order_item_sort(order_id)
    order_items.find(order_id)
  end
end
