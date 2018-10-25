require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:img_url) }
    it { should validate_presence_of(:inventory_count) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:user_id) }
  end
  describe "relationships" do
    it { should belong_to(:user) }
    it { should have_many(:order_items) }
    it { should have_many(:orders).through(:order_items) }
  end

end
