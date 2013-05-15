module Shirtsio
  class Status < APIResource

    @status_url = 'status/'

    def Status.get_order_status(params={})
      order_id = params[:order_id]
      order_status_url = @status_url + order_id + '/'
      response, api_key = Shirtsio.request(:get, order_status_url, @api_key, params={})
      #Util.convert_to_shirtsio_object(response, api_key)
      response
    end

  end
end