module Shirtsio
  class Order < APIResource

    @order_url = 'order/'

    def Order.place_order(params={})
      response, api_key = Shirtsio.request(:post, @order_url, @api_key, params)
      Util.convert_to_shirtsio_object(response, api_key)
      response
    end

  end
end