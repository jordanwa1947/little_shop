admin = User.create(
  name: "admin",
  address: "123 street",
  city: "Denver",
  state: "CO",
  zip_code: 80000,
  password: "admin",
  email: "admin@admin.com",
  role: :admin_user
)
user_1 = User.create(
  name: "Jim Jones",
  address: "123 Paradise Way",
  city: "Jonestown",
  state: "PA",
  zip_code: 66667,
  password: "password77",
  email: "livin_to_die@example.com"
)
user_2 = User.create(
  name: "Jefferey Dahmer",
  address: "321 Main Street",
  city: "Milwaukee",
  state: "WI",
  zip_code: 54122,
  password: "password1",
  email: "too_much_fun@example.com"
)
user_3 = User.create(
  name: "Ted Bundy",
  address: "776 Example Ave",
  city: "Chicago",
  state: "IL",
  zip_code: 66754,
  password: "qwerty123",
  email: "must_love_dogs@example.com"
)
user_4 = User.create(
  name: "Edward Gein",
  address: "555 Murphy Road",
  city: "Plainsville",
  state: "WI",
  zip_code: 54321,
  password: "qdawg45",
  email: "a_boys_best_friend@example.com"
)
user_5 = User.create(
  name: "Charles Manson",
  address: "765 Hollywood blvd",
  city: "Hollywood",
  state: "CA",
  zip_code: 78901,
  password: "password65",
  email: "helter_skelter@example.com"
)
user_6 = User.create(
  name: "Felicity Huffman",
  address: "12 Not-the Way",
  city: "Pleasantville",
  state: "WA",
  zip_code: 68927,
  password: "password34",
  email: "ruffnbuff@example.com",
  role: :merchant_user
)
user_7 = User.create(
  name: "Sally Field",
  address: "6612 Purpose Street",
  city: "Reno",
  state: "NV",
  zip_code: 76542,
  password: "password99",
  email: "applepie@example.com",
  role: :merchant_user
)
user_8 = User.create(
  name: "Bette White",
  address: "767 Main St",
  city: "Santa Fe",
  state: "NM",
  zip_code: 98537,
  password: "qwer67",
  email: "cute_for_you@example.com",
  role: :merchant_user
)
user_9 = User.create(
  name: "Jennifer Lawerence",
  address: "5785 Candle blvd",
  city: "Augusta",
  state: "MO",
  zip_code: 76678,
  password: "jlaw98",
  email: "livin_loca889@example.com",
  role: :merchant_user
)
user_10 = User.create(
  name: "Margeret Thatcher",
  address: "8896 Dev ave.",
  city: "New York",
  state: "NY",
  zip_code: 99876,
  password: "password99",
  email: "dream_gal@example.com",
  role: :merchant_user
)

item_1 = Item.create(
  name: "Shovel",
  description: "A good way to get attention. Bring one to parties.",
  price: 16,
  img_url:        "http://www.colourbox.com/preview/7389458-682747-example-stamp.jpg",
  inventory_count: 20,
  user: user_6
)
item_2 = Item.create(
  name: "Kool Aid",
  description: "Transcend to the next level! Oh Yeah!", price: 3,
  img_url: "http://www.colourbox.com/preview/7389458-682747-example-stamp.jpg",
  inventory_count: 30,
  status: 1,
  user: user_7
)
item_3 = Item.create(
  name: "Possum Sweater",
  description: "Big in New Zealand.",
  price: 67,
  img_url: "http://www.colourbox.com/preview/7389458-682747-example-stamp.jpg",
  inventory_count: 40,
  user: user_8
)
item_4 = Item.create(
  name: "Beef Jerky",
  description: "Good for camping trips and picnics.",
  price: 13,
  img_url: "http://www.colourbox.com/preview/7389458-682747-example-stamp.jpg",
  inventory_count: 50,
  status: 1,
  user: user_9
)
item_5 = Item.create(
  name: "Banana Pudding",
  description: "Banana flavored pudding",
  price: 9,
  img_url: "http://www.colourbox.com/preview/7389458-682747-example-stamp.jpg",
  inventory_count: 60,
  user: user_10
)

order_1 = user_1.orders.create(status: :complete)
order_2 = user_1.orders.create(status: :complete)
order_3 = user_2.orders.create(status: :pending)
order_4 = user_2.orders.create(status: :complete)
order_5 = user_3.orders.create(status: :complete)

order_item_1 = OrderItem.create(
  item_id: item_1.id,
  order_id: order_1.id,
  item_quantity: 5,
  item_price: item_1.price
)
order_item_2 = OrderItem.create(
  item_id: item_4.id,
  order_id: order_1.id,
  item_quantity: 3,
  item_price: item_4.price
)
order_item_3 = OrderItem.create(
  item_id: item_2.id,
  order_id: order_2.id,
  item_quantity: 7,
  item_price: item_2.price
)
order_item_4 = OrderItem.create(
  item_id: item_3.id,
  order_id: order_2.id,
  item_quantity: 2,
  item_price: item_3.price
)
order_item_5 = OrderItem.create(
  item_id: item_5.id,
  order_id: order_3.id,
  item_quantity: 100,
  item_price: item_5.price
)
order_item_6 = OrderItem.create(
  item_id: item_5.id,
  order_id: order_4.id,
  item_quantity: 10,
  item_price: item_5.price
)
order_item_7 = OrderItem.create(
  item_id: item_4.id,
  order_id: order_5.id,
  item_quantity: 1,
  item_price: item_4.price
)
