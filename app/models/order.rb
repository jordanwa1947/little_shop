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


  def item_sort(merchant_id)
    items.where('user_id = ?', merchant_id)
  end

  # dashboard index instance methods for order and
  # tests are on the back burner for now

  # def merchant_orders(current_user_id)
  #   distinct.joins(:items).where('items.user_id = ?', current_user_id)
  # end
  #
  # def merchant_orders_admin(merchant_id)
  #   distinct.joins(:items).where('items.user_id = ?', merchant_id)
  # end

  def self.count_by_status(status)
    # group(status).count
    # binding.pry
  end
end
