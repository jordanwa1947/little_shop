class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, presence: true
  validates :price, presence: true
  validates :img_url, presence: true
  validates :inventory_count, presence: true
  validates :status, presence: true
  validates :user_id, presence: true

  enum status: %w(active, disabled)
end
