class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  validates_presence_of :user_id, :status

  enum status: %w(pending complete)

  def total_price
    items.inject(0) do |sum, item|
      sum += item.price
    end
  end

  def total_quantity
    order_items.inject(0) do |sum, order_item|
      sum += order_item.item_quantity
    end
  end

end
