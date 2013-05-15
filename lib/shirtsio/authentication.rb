module Shirtsio
  class Authentication < APIResource

    @auth_url = 'internal/integration/auth/'

    def Authentication.auth(params={})
      response, api_key = Shirtsio.request(:get, @auth_url, @api_key, params)
      Util.convert_to_shirtsio_object(response, api_key)
      response
    end

  end
end