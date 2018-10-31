class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  validates_presence_of :name, :price, :img_url, :inventory_count, :status, :user_id, :description

  enum status: %w(active disabled)

  def self.three_highest_selling_items
    items = group(:id).joins(:order_items).sum(:item_quantity)
    desc = items.sort {|a,b| b[1]<=>a[1]}
    top_three = desc[0..2].map do |item|
      Item.find(item.first.to_i)
    end
  end
end
