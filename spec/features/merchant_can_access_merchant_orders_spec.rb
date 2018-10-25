require 'ra\" , price:16 , img_url:"http://www.colourbox.com/preview/7389458-682747-example-stamp.jpg" , inventory_count:20 , user:@user_6 )
      @item_2 = Item.create(name:"Kool Aid" , price:3 , img_url:"http://www.colourbox.com/preview/7389458-682747-example-stamp.jpg" , inventory_count:30 ,status:1 , user:@user_7 )

      @order_1 = Order.create(user:@user_1 , status:0 )
      @order_2 = Order.create(user:@user_2 , status:1 )

      order_item_1 = OrderItem.create(order:@order_1 , item:@item_1 )
      order_item_2 = OrderItem.create(order:@order_2 , item:@item_2 )
    end

      it "creates a link that redirects to dashboard displaying all merchant orders " do
        expect(@customer.orders).to include(@order)
        expect(@customer.ordered_books).to include(@book)
      end
    end
