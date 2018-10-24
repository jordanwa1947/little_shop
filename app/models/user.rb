class User < ApplicationRecord
  validates_presence_of :name, require: true
  validates_presence_of :address, require: true
  validates_presence_of :city, require: true
  validates_presence_of :state, require: true
  validates_presence_of :zip_code, require: true
  validates_presence_of :password_digest, require: true
  validates :email, presence: true, uniqueness: true
  validates_confirmation_of :password

  has_many :items
  has_many :orders
  has_many :order_items, through: :orders

  has_secure_password

  enum role: %w(default, registered_user, merchant_user, admin_user)
  enum status: %w(active, disabled)

end
