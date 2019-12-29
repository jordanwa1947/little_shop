class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  validates_presence_of :name, :price, :inventory_count, :status, :user_id, :description
  validates :price, numericality: true
  validates :price, :numericality => {greater_than: 0}
  validates :inventory_count, numericality: true
  validates :inventory_count, :numericality => {greater_than_or_equal_to: 0}

  enum status: %w(active disabled)

  def order_item_sort(order_id)
    order_items.find_by('order_id = ?', order_id)
  end

  def self.three_highest_selling_items
    items = select('items.*, sum(order_items.item_quantity * order_items.item_price) as total')
    .group(:id)
    .joins(:order_items)
    .order('total ASC')
    .limit(3)
  end

  def self.search(query, only_active)
    if query && only_active
      where("LOWER(name) LIKE :search", search: "%#{query.downcase}%")
      .where(status: :active);
    elsif only_active
      where(status: :active);
    elsif query
      where("LOWER(name) LIKE :search", search: "%#{query.downcase}%");
    else
      all();
    end
  end

end
