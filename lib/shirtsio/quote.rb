module Shirtsio
  class Quote < APIResource

    @quote_url = 'quote/'

    def Quote.get_quote(params={})
      response, api_key = Shirtsio.request(:get, @quote_url, @api_key, params)
      #Util.convert_to_shirtsio_object(response, api_key)
      response
    end

  end
end