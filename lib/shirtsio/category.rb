module Shirtsio
  class Category < APIResource

    @category_url = 'products/category/'

    def Category.all(params={})
      response, api_key = Shirtsio.request(:get, @category_url, @api_key, params)
      Util.convert_to_shirtsio_object(response, api_key)
    end

  end
end