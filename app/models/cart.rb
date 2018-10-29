class Cart
  attr_reader :contents, :items

  def initialize(initial_contents)
    @contents = initial_contents || {}
    @items = contents.keys.map do |item_id|
      Item.find(item_id.to_i)
    end
  end

  def add_item(item_id)
    contents[item_id.to_s] ||= 0
    contents[item_id.to_s] += 1
  end

  def subtract_item(item_id)
    if contents[item_id.to_s] > 0
      contents[item_id.to_s] -= 1
    elsif contents[item_id.to_s] == 0
      contents.delete(item_id.to_s)
    end
  end

  def count_all
    contents.values.sum
  end

  def quantity(item_id)
    contents[item_id.to_s]
  end

  def merchant(item_id)
    User.find(Item.find(item_id.to_i).user_id)
  end

  def total_price
    items.inject(0) do |sum, item|
      sum + (item.price * quantity(item.id) )
    end
  end

end
