class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  validates_presence_of :user_id, :status

  enum status: %w(pending complete cancelled)

  def total_price
    order_items.inject(0) do |sum, item|
      sum + (item.item_price * item.item_quantity)
    end
  end

  def total_items
    order_items.inject(0) do |sum, item|
      sum + (item.item_quantity)
    end
  end

  def item_sort(order, merchant_id)
    order.items.where('user_id = ?', merchant_id)
  end

  def self.merchant_orders(current_user_id)
    distinct.joins(:items).where('items.user_id = ?', current_user_id)
  end

  def self.merchant_orders_admin(merchant_id)
    distinct.joins(:items).where('items.user_id = ?', merchant_id)
  end

  def complete?
    return true if order_items.where('fulfilled = ?', false).count == 0
  end
end
