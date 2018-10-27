class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  validates_presence_of :user_id, :status

  enum status: %w(pending complete)
end
