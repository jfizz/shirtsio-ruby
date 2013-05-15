#require File.expand_path('../../lib/*', __FILE__)
require "shirtsio"

Shirtsio.api_key = '3ef58f89c6c8d0ce3f71e4ab3537db4e24d6ac40'

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
#params = {'garment[0][product_id]' => 3, 'garment[0][color]' => 'White',
#          'garment[0][sizes][med]' => 100, 'print[front][color_count]' => 5}
#quote = Shirtsio::Quote.get_quote(params)
#puts quote[:result][:subtotal]

###### Auth ######
#params = {'username' => 'deantest', 'password' => 'Pa$$w0rd'}
#auth_result = Shirtsio::Authentication.auth(params)
#puts auth_result[:result][:api_key]

###### Webhooks ######
#params = {'username' => 'deantest', 'password' => 'Pa$$w0rd'}
new_webhooks = Shirtsio::Webhooks.register(:url => 'www.baidu.com')
puts new_webhooks[:result]

delete_webhooks = Shirtsio::Webhooks.delete(:url => 'www.baidu.com')
puts delete_webhooks[:result]

webhooks = Shirtsio::Webhooks.list()
puts webhooks[:result][:listener_url]