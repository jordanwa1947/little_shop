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

  def count_all
    contents.values.sum
  end

  def quantity(item_id)
    contents[item_id.to_s]
  end

end
