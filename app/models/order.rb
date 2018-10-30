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

end
