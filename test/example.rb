#require File.expand_path('../../lib/*', __FILE__)
require "shirtsio"

Shirtsio.api_key = 'a086134c5625ebfd4e080d19749bc0cb736ad1d5'

###### Category ######
#categories = Shirtsio::Category.all()
#puts categories.result

###### Product ######
#products = Shirtsio::Product.list_products(:category_id => "3")
#puts products.result
#
#product = Shirtsio::Product.get_product(:product_id => "5")
#puts product.result

#product = Shirtsio::Product.inventory_count(:product_id => "5", :color => "White", :state => "CA")
#puts product[:result][:inventory]


###### Quote ######
params = {'garment[0][product_id]' => 3, 'garment[0][color]' => 'White',
          'garment[0][sizes][med]' => 100, 'print[front][color_count]' => 5}
quote = Shirtsio::Quote.get_quote(params)
puts quote[:result][:subtotal]

###### Status ######
