module Shirtsio
  class Status < APIResource

    @status_url = 'status/'

    def Status.get_order_status(params={})
      response, api_key = Shirtsio.request(:get, @status_url, @api_key, params)
      Util.convert_to_shirtsio_object(response, api_key)
      response
    end

  end
end