module Shirtsio
  class Webhooks < APIResource

    @webhooks_url = 'webhooks/'

    def Webhooks.list(params={})
      webhooks_list_url = @webhooks_url + 'list/'
      response, api_key = Shirtsio.request(:get, webhooks_list_url, @api_key, params)
      Util.convert_to_shirtsio_object(response, api_key)
      response
    end

    def Webhooks.register(params={})
      webhooks_register_url = @webhooks_url + 'register/'
      response, api_key = Shirtsio.request(:post, webhooks_register_url, @api_key, params)
      Util.convert_to_shirtsio_object(response, api_key)
      response
    end

    def Webhooks.delete(params={})
      webhooks_delete_url = @webhooks_url + 'delete/'
      response, api_key = Shirtsio.request(:post, webhooks_delete_url, @api_key, params)
      Util.convert_to_shirtsio_object(response, api_key)
      response
    end

    def Webhooks.register_payment(params={})
      webhooks_payment_url = 'payment/status'
      response, api_key = Shirtsio.request(:post, webhooks_payment_url, @api_key, params)
      Util.convert_to_shirtsio_object(response, api_key)
      response
    end
  end
end