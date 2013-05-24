#require File.expand_path('../../lib/*', __FILE__)
require "shirtsio"

Shirtsio.api_key = '0ef58f89c6c8d0ce3f71e4ab3537db4e24d6ac40'


###### Category ######
#categories = Shirtsio::Category.all()
#puts categories.result


###### Product ######
#products = Shirtsio::Product.list_products(:category_id => "3")
#puts products[:result]
#
#product = Shirtsio::Product.get_product(:product_id => "5")
#puts product[:result]
#
#product = Shirtsio::Product.inventory_count(:product_id => "5", :color => "White", :state => "CA")
#puts product[:result][:inventory]


###### Quote ######
#params = {'garment[0][product_id]' => 3, 'garment[0][color]' => 'White',
#          'garment[0][sizes][med]' => 100, 'print[front][color_count]' => 5}
#quote = Shirtsio::Quote.get_quote(params)
#puts quote[:result][:subtotal]

###### Webhooks ######
#new_webhooks = Shirtsio::Webhooks.register(:url => 'www.baidu.com')
#puts new_webhooks[:result]
#
#delete_webhooks = Shirtsio::Webhooks.delete(:url => 'www.baidu.com')
#puts delete_webhooks[:result]
#
#webhooks = Shirtsio::Webhooks.list()
#puts webhooks[:result][:listener_url]


###### Order ######
#Dir.chdir(File.dirname(__FILE__))
#artwork_front = File.new("front.png", 'rb')
#proof_front = File.new("front.jpg", 'rb')
#artwork_back = File.new("back.png", 'rb')
#proof_back = File.new("back.jpg", 'rb')
#puts artwork_front
#
#data = {
#    :multipart => true,
#    'test' => "True", 'price' => '79.28',
#    'print[back][color_count]' => '4', 'print[back][colors][0]' => "101C", 'print[back][colors][1]' => '107U',
#    'addresses[0][name]' => 'John Doe', 'addresses[0][address]' => '123 Hope Ln.',
#    'addresses[0][city]' => 'Las Vegas', 'addresses[0][state]' => 'Nevada', 'addresses[0][country]' => 'US',
#    'addresses[0][zipcode]' => '12345', 'addresses[0][batch]' => 1, 'addresses[0][sizes][med]' => '2',
#    'addresses[0][sizes][lrg]' => '2',
#    'print_type' => 'Digital Print', 'ship_type' => 'Standard',
#    'garment[0][product_id]' => '2', 'garment[0][color]' => "White",
#    'garment[0][sizes][med]' => '2', 'garment[0][sizes][lrg]' => '2', 'print[front][color_count]' => '5',
#    'print[front][artwork]' => artwork_front, 'print[front][proof]' => proof_front,
#    'print[back][artwork]' => artwork_back, 'print[back][proof]' => proof_back
#}
#
#order = Shirtsio::Order.place_order(data)
#puts order[:result]


###### Status ######
#order_status = Shirtsio::Status.get_order_status(:order_id => '999999')
#puts order_status
